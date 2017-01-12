class LessonplansController < ApplicationController
  before_action :set_lessonplan, only: [:show, :edit, :update, :destroy]

  # GET /lessonplans
  # GET /lessonplans.json
  def index
    unless current_user.role.rights.where("value = 'view_lesson_plans'").any? || current_user.role.name == 'Teacher'
      redirect_to root_path, alert: 'Sorry! You are not authorized...!!!'
    end
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      if current_user.role.name != "Teacher"
        @lessonplans = @year_plan.lessonplans
      else
        grade_ids = Employee.find_by_email(current_user.email).bridges.pluck(:grade_id)
        subject_ids = Employee.find_by_email(current_user.email).bridges.pluck(:subject_id)
        @lessonplans = @year_plan.lessonplans.where(grade_id: grade_ids, subject_id: subject_ids)
      end
    end
  end

  # GET /lessonplans/1
  # GET /lessonplans/1.json
  def show
  end

  # GET /lessonplans/new
  def new
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      @lessonplan = @year_plan.lessonplans.build
      if current_user.role.name == 'Teacher'
        @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id)) rescue nil
        @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id)) rescue nil
      else
        # for admins
        @grades = Grade.all
        @subjects = Subject.all
      end
      # @subjects = Subject.all
      # @grades = Grade.all
    end
  end

  # GET /lessonplans/1/edit
  def edit
    if current_user.role.name == 'Teacher'
      @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id))
      @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id))
    else
      # for admins
      @grades = Grade.where('section IS NOT NULL').order('name')
      @subjects = Subject.all
    end
  end

  # POST /lessonplans
  # POST /lessonplans.json
  def create

    # return render json: params[:lessonplan_detail_file]
    @year_plan = YearPlan.find(params[:lessonplan][:year_plan_id])

    if @year_plan.present?
      grade_id = params[:lessonplan][:grade_id] || []
      @lessonplan = Lessonplan.new(grade_id: grade_id, subject_id: lessonplan_params[:subject_id],
                                       year_plan_id: lessonplan_params[:year_plan_id] )
      @lessonplan.assign_attributes(lessonplan_params)
      @lessonplan.grade_id = grade_id
      @success = false
      if @lessonplan.save
          # return render json: params[:lessonplan_detail_file][i]
        Notification.create(user_id: current_user.id, activity: "Added Lesson Plan for #{@lessonplan.subject.name}, grade #{@lessonplan.grade.full_name}"  )

        avs = @lessonplan.lessonplan_details.create!(period: params[:lessonplan_detail_days], procedure: params[:lessonplan_detail_details])
        avs.attachment = params[:lessonplan_detail_file]
        avs.save!
        @success = true
      end

   respond_to do |format|
        if @success
          format.html { redirect_to lessonplans_path(year_plan: @year_plan.id), notice: 'Lesson plan was successfully created. And requested for approval' }
          format.json { render :show, status: :created, location: @lessonplan }
        else
          format.html { render :new }
          format.json { render json: @lessonplan.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /lessonplans/1
  # PATCH/PUT /lessonplans/1.json
  def update
    respond_to do |format|
      if @lessonplan.update(lessonplan_params)
        @lessonplan.approved = false
        @lessonplan.save!
        format.html { redirect_to @lessonplan, notice: 'Lessonplan was successfully updated.' }
        format.json { render :show, status: :ok, location: @lessonplan }
      else
        format.html { render :edit }
        format.json { render json: @lessonplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessonplans/1
  # DELETE /lessonplans/1.json
  def destroy
    @lessonplan.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Lessonplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_requested
    if current_user.role.rights.where(value: 'approve_lesson').any?
      @lessonplans = []
      my_lessons = Lessonplan.where(approved: false)
      my_lessons.each do |lp|
        br = Bridge.where(subject_id: lp.subject_id, grade_id: lp.grade_id).first
        if br.present?
          usr = User.find_by_email(br.employee.email)
          if usr.present?
            @lessonplans << {lessonplan: lp, teacher_name: br.employee.full_name, teacher_id: usr.id}
          else
          end
        else
        end
      end
    else
      redirect_to root_path, alert: "You are not authorized...!!!"
    end
  end

  def approve_requested
    lessonplan = Lessonplan.find(params[:lessonplan_id])
    if lessonplan.present?
      lessonplan.approved = true
      lessonplan.save!
      flash[:success] = "Approved Request"
    else
      flash[:alert] = "Couldn't find lesson plan"
    end
    redirect_to :back
  end

  def disapprove_requested
    lessonplan = Lessonplan.find(params[:lessonplan_id])
    if lessonplan.present?
      lessonplan.approved = nil
      lessonplan.save!
      # flash[:success] = "Dispproved Request"
    else
      # flash[:alert] = "Couldn't find lessonplan"

    end
    respond_to do |format|
      # format.json { render json: json_response, status: :success }
      format.json { head :ok }
    end
  end

  def approve_all_requests
    if current_user.role.rights.where(value: 'approve_curriculam')
      lessonplans = Lessonplan.where(approved: false)
      lessonplans.each do |lessonplan|
        lessonplan.approved = true
        lessonplan.save!
      end
      flash[:success] = "Approved all the lesson plans"
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessonplan
      if current_user.role.rights.where(value: 'approve_curriculam')
        @lessonplan = Lessonplan.find(params[:id])
      else
        @lessonplan = Lessonplan.where(id: params[:id]).first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lessonplan_params
      params.require(:lessonplan).permit(:grade_id, :subject_id, :topic, :selection, :startdate, :enddate, :studentengage, :newvocabulary, :objectives,:year_plan_id)
    end
end
