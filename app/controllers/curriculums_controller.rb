class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  # GET /curriculums
  # GET /curriculums.json
  def index
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      if current_user.role.name != "Teacher"
        @curriculums = @year_plan.curriculums
      else
        grade_ids = Employee.find_by_email(current_user.email).bridges.pluck(:grade_id)
        subject_ids = Employee.find_by_email(current_user.email).bridges.pluck(:subject_id)
        @curriculums = @year_plan.curriculums.where(grade_id: grade_ids, subject_id: subject_ids)
      end
    end
  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show
  end

  # GET /curriculums/new
  def new
     @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      @curriculum = @year_plan.curriculums.build
      if current_user.role == 'teacher'
        @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id))
        @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id))
      elsif current_user.role!= 'parent' && current_user.role!= 'student'
        # for admins
        @grades = Grade.all
        @subjects = Subject.all
      end
      # @subjects = Subject.all
      # @grades = Grade.all
    end
  end

  # GET /curriculums/1/edit
  def edit
    if current_user.role == 'teacher'
      @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id))
      @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id))
    elsif current_user.role!= 'parent' && current_user.role!= 'student'
      # for admins
      @grades = Grade.all
      @subjects = Subject.all
    end
  end
  # POST /curriculums
  # POST /curriculums.json
  def create
   @year_plan = YearPlan.find(params[:curriculum][:year_plan_id])

    if @year_plan.present?
      @curriculum = @year_plan.curriculums.build(curriculum_params)

      respond_to do |format|
        if @curriculum.save

          params[:curriculum_detail_months].each_with_index do |detail_months,i|
            @curriculum.curriculum_details.create!(month: params[:curriculum_detail_months][i], day: params[:curriculum_detail_days][i].to_i, sol: params[:curriculum_detail_sols][i], strand: params[:curriculum_detail_strands][i], content: params[:curriculum_detail_contents][i], skill: params[:curriculum_detail_skills][i], activity: params[:curriculum_detail_activities][i],assessment: params[:curriculum_detail_assessments][i])
          end

          format.html { redirect_to curriculums_path(year_plan: @year_plan.id), notice: 'Curriculum was successfully created. And requested for approval' }
          format.json { render :show, status: :created, location: @curriculum }
        else
          format.html { render :new }
          format.json { render json: @curriculum.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /curriculums/1
  # PATCH/PUT /curriculums/1.json
  def update
    respond_to do |format|
      if @curriculum.update(curriculum_params)
        @curriculum.approved = false
        @curriculum.save!
        format.html { redirect_to @curriculum, notice: 'Curriculum was successfully updated.' }
        format.json { render :show, status: :ok, location: @curriculum }
      else
        format.html { render :edit }
        format.json { render json: @curriculum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculums/1
  # DELETE /curriculums/1.json
  def destroy
    @curriculum.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Curriculum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_requested
    if current_user.role == "admin"
      @curriculums = []
      my_curs = Curriculum.where(approved: false)
      my_curs.each do |cur|
        br = Bridge.where(subject_id: cur.subject_id, grade_id: cur.grade_id).first
        if br.present?
          usr = User.find_by_email(br.employee.email)
          if usr.present?
            @curriculums << {curriculum: cur, teacher_name: br.employee.full_name, teacher_id: usr.id}
          else
          end
        else
        end
      end
    end
  end

  def approve_requested
    # return render json: params.inspect
    curriculum = Curriculum.find(params[:curriculum_id])
    if curriculum.present?
      curriculum.approved = true
      curriculum.save!
      flash[:success] = "Approved Request"
    else
      flash[:alert] = "Couldn't find curriculum"
    end
    redirect_to :back
  end

  def disapprove_requested
    # return render json: params.inspect
    curriculum = Curriculum.find(params[:curriculum_id])
    if curriculum.present?
      curriculum.approved = nil
      curriculum.save!
      # flash[:success] = "Dispproved Request"
    else
      # flash[:alert] = "Couldn't find curriculum"

    end
    respond_to do |format|
      # format.json { render json: json_response, status: :success }
      format.json { head :ok }
    end
  end

  def approve_all_requests
    if current_user.role == "admin"
      my_curs = Curriculum.where(approved: false)
      my_curs.each do |cur|
        cur.approved = true
        cur.save!
      end
      flash[:success] = "Approved all the curriculums"
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      if current_user.role == "admin"
        @curriculum = Curriculum.find(params[:id])
      else
        @curriculum = Curriculum.where(id: params[:id]).first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curriculum_params
      params.require(:curriculum).permit(:grade_id, :subject_id, :studentname)
    end
end
