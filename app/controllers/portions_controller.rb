class PortionsController < ApplicationController
  before_action :set_portion, only: [:show, :edit, :update, :destroy]

  # GET /portions
  # GET /portions.json
  def index
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      if current_user.role == "admin"
        @portions = @year_plan.portions
      else
        grade_ids = Employee.find_by_email(current_user.email).bridges.pluck(:grade_id)
        @portions = @year_plan.portions.where(grade_id: grade_ids)
      end
    end
  end

  # GET /portions/1
  # GET /portions/1.json
  def show

  end

  # GET /portions/new
  def new
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      @portion = @year_plan.portions.build
      if current_user.role == 'teacher'
        @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id))
        @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id))
      elsif current_user.role!= 'parent' && current_user.role!= 'student' 
        # for admins
        @grades = Grade.all
        @subjects = Subject.all
      end
      # @subjects = Subject.all
    end
  end

  # GET /portions/1/edit
  def edit
    if current_user.role == 'teacher'
        # @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id))
        @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id))
      elsif current_user.role!= 'parent' && current_user.role!= 'student' 
        # for admins
        # @grades = Grade.all
        @subjects = Subject.all
      end
  end

  # POST /portions
  # POST /portions.json
  def create
    # return render json: params.inspect

    @year_plan = YearPlan.find(params[:portion][:year_plan_id])

    if @year_plan.present?
      @portion = @year_plan.portions.build(portion_params)

      respond_to do |format|
        if @portion.save

          params[:portion_detail_subjects].each_with_index do |detail_subject,i|
            @portion.portion_details.create!(subject_id: params[:portion_detail_subjects][i].to_i, details: params[:portion_detail_details][i], note: params[:portion_detail_notes][i])
          end
          format.html { redirect_to portions_path(year_plan: @year_plan.id), notice: 'Portion was successfully created. And requested for approval' }
          format.json { render :show, status: :created, location: @portion }
        else
          format.html { render :new }
          format.json { render json: @portion.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /portions/1
  # PATCH/PUT /portions/1.json
  def update
    respond_to do |format|
      if @portion.update(portion_params)
        @portion.approved = false
        @portion.save!
        format.html { redirect_to @portion, notice: 'Portion was successfully updated.' }
        format.json { render :show, status: :ok, location: @portion }
      else
        format.html { render :edit }
        format.json { render json: @portion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portions/1
  # DELETE /portions/1.json
  def destroy
    @portion.portion_details.destroy_all
    @portion.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Portion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_requested
    if current_user.role == "admin"
      @portions = [] 
      my_portions = Portion.where(approved: false)
      my_portions.each do |portion|
        br = Bridge.where(subject_id: portion.portion_details.first.subject_id, grade_id: portion.grade_id).first
        if br.present?
          usr = User.find_by_email(br.employee.email)
          if usr.present?
            @portions << {portion: portion, teacher_name: br.employee.full_name, teacher_id: usr.id}
          else
          end
        else
        end
      end
    end
  end

  def approve_requested
    portion = Portion.find(params[:portion_id])
    if portion.present?
      portion.approved = true
      portion.save!
      flash[:success] = "Approved Request"
    else
      flash[:alert] = "Couldn't find portion"
    end
    redirect_to :back
  end

  def disapprove_requested
    portion = Portion.find(params[:portion_id])
    if portion.present?
      portion.approved = nil
      portion.save!
      # flash[:success] = "Dispproved Request"
    else
      # flash[:alert] = "Couldn't find portion"

    end
    respond_to do |format|
      # format.json { render json: json_response, status: :success }
      format.json { head :ok }
    end
  end

  def approve_all_requests
    if current_user.role == "admin"
      portions = Portion.where(approved: false)
      portions.each do |portion|
        portion.approved = true
        portion.save!
      end
      flash[:success] = "Approved all the portions"
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portion
      if current_user.role == "admin"
        @portion = Portion.find(params[:id])
      else
        @portion = Portion.where(id: params[:id]).first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portion_params
      params.require(:portion).permit(:year_plan_id, :quarter, :grade_id)
    end
end
