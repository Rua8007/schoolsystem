class YearPlansController < ApplicationController
  before_action :set_year_plan, only: [:show, :edit, :update, :destroy]

  # GET /year_plans
  # GET /year_plans.json
  def index
    if current_user.right.role.rights(value: "view_weeklyplans")
      @year_plans = YearPlan.all
      @grades = Grade.all
    else
      redirect_to root_path, alert: "access denied"
    end
  end

  # GET /year_plans/1
  # GET /year_plans/1.json
  def show
    @weeks = @year_plan.weeks.sort_by &:start_date
    if current_user.role.name == 'Teacher'
      @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id)) rescue []
      @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id)) rescue []
    elsif current_user.role.rights.where(value: "view_weeklyplans").any?
      # for admins
      @grades = Grade.all
      @subjects = Subject.all
    end

  end

  # GET /year_plans/new
  def new
    @year_plan = YearPlan.new
  end

  # GET /year_plans/1/edit
  def edit
  end

  # POST /year_plans
  # POST /year_plans.json
  def create
    @year_plan = YearPlan.new(year_plan_params)

    respond_to do |format|
      if @year_plan.save
        format.html { redirect_to root_path, notice: 'Year plan was successfully created.' }
        format.json { render :show, status: :created, location: @year_plan }
      else
        format.html { render :new }
        format.json { render json: @year_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /year_plans/1
  # PATCH/PUT /year_plans/1.json
  def update
    respond_to do |format|
      if @year_plan.update(year_plan_params)
        format.html { redirect_to root_path, notice: 'Year plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @year_plan }
      else
        format.html { render :edit }
        format.json { render json: @year_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /year_plans/1
  # DELETE /year_plans/1.json
  def destroy
    @year_plan.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Year plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_schedule
    @year_plan = YearPlan.find(params[:id])
    weeks = @year_plan.weeks.sort_by &:start_date
    @grade = Grade.find(params[:grade_id])
    @subject = Subject.find(params[:subject_id])

    @rows = []
    @max_days = 0
    weeks.each_with_index do |week,i|
      row_data = {}
      row_data.store("week_num","#{i+1}")
      row_data.store("date","#{week.start_date.strftime("%d/%m")} - #{week.end_date.strftime("%d/%m")}")
      days = GradeSubject.where(week_id: week.id, grade_id: @grade.id, subject_id: @subject.id)
      if days.count > @max_days
        @max_days = days.count
      end
      hash_days = []
      days.each do |day|
        myday = {}
        myday.store("cw","#{day.classwork}")
        myday.store("hw","#{day.homework}")
        myday.store("approved_status","#{day.approved}")
        hash_days << myday
      end
      row_data.store("days", hash_days)
      @rows << row_data
    end
  end

  def weekly_schedule
    @year_plan = YearPlan.find(params[:id])
    @weeks = @year_plan.weeks.sort_by &:start_date
    if current_user.role.name == 'Teacher'
      @grades = Grade.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:grade_id)) rescue []
      # @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id))
    else
      # for admins
      @grades = Grade.all
      # @subjects = Subject.all
    end
    # @grades = Grade.all
  end

  def show_weekly_schedule
    # return render json: params.inspect
    @year_plan = YearPlan.find(params[:id])
    @grade = Grade.find(params[:grade_id])
    @week = Week.find(params[:week_id])

    if current_user.role.name == 'Teacher'
      @subjects = Subject.where(id: Employee.find_by_email(current_user.email).bridges.pluck(:subject_id)).order('name') rescue []
    else
      @subjects = Subject.all.order('name')
    end
    @subject = params[:subject_id].present? ? Subject.find(params[:subject_id]) : @subjects.first
    @results = []
    @weekends = Weekend.all
    @schedules = GradeSubject.where("subject_id = ? AND grade_id = ? AND week_id =  ?", @subject.id, params[:grade_id], params[:week_id] )

    if params[:commit] == 'Show Weekly Plan' or params[:format] == 'pdf'

      if current_user.role.name == Role::SUPER_USER_ROLE
        @print_schedules = GradeSubject.where('grade_id = ? AND week_id =  ?',
                           params[:grade_id], params[:week_id] ).try(:order, 'day_name_eng')
      else
        @print_schedules = GradeSubject.where("grade_id = ? AND week_id =  ? AND subject_id IN(#{@subjects.pluck(:id).join(',')})",
                                              params[:grade_id], params[:week_id] ).try(:order, 'day_name_eng')
      end

      respond_to do |format|
        format.pdf {
          render pdf: "#{@week.label}", template: 'year_plans/print_weekly_schedule.pdf.erb', layout: 'pdf.html.erb',
                 margin: { top: 30, bottom: 11, left: 5, right: 5},
                 header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
                 footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }

        }
        format.html{ render 'complete_weekly_schedule' }
      end
    end
  end

  def update_weekly_schedule
    schedule_ids = params[:ids]
    class_works = params[:classworks]
    home_works = params[:homeworks]
    schedule_ids.try(:each_with_index) do |schedule_id, index|
      schedule = GradeSubject.find schedule_id
      schedule.homework = home_works[index] if home_works.present?
      schedule.classwork = class_works[index] if class_works.present?
      schedule.save
    end
    flash[:notice] = 'Request Completed.'
    redirect_to root_path
  end

  def delete_weekly_schedule
    # return render json: params.inspect
    week = GradeSubject.find(params[:id])
    if week.present?
      week.destroy
      flash[:success] = "successfully deleted the week."
    else
      flash[:alert] = "Week not found."
    end
    redirect_to root_path
  end

  def get_requested
    @weekly_plans = []
    my_weekly_plans = GradeSubject.where.not(approved: true)
    my_weekly_plans.each do |wp|
      br = Bridge.where(subject_id: wp.subject_id, grade_id: wp.grade_id).first

      if br.present?
        usr = User.find_by_email(br.employee.email) if br.employee.present?
        if usr.present?
          @weekly_plans << {weekly_plan: wp, teacher_name: br.employee.full_name, teacher_id: usr.id}
        else
          # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        end
      else
        # puts "-------------------------------"
      end
    end

      # puts "****"*500
      # puts @weekly_plans.inspect

      # return render json: @weekly_plans.first[:weekly_plan].classwork
  end

  def approve_requested
    weekly_plan = GradeSubject.find(params[:weekly_plan_id])
    if weekly_plan.present?
      weekly_plan.approved = true
      weekly_plan.save!
      flash[:success] = "Approved Request"
    else
      flash[:alert] = "Couldn't find weekly_plan"
    end
    redirect_to :back
  end

  def disapprove_requested
    weekly_plan = GradeSubject.find(params[:weekly_plan_id])
    if weekly_plan.present?
      weekly_plan.approved = nil
      weekly_plan.save!
      json_response = "Dispproved Request"
    else
      json_response = "Couldn't find weekly_plan"
    end
    respond_to do |format|
      # format.json { render json: json_response, status: :success }
      format.json { head :ok }
    end

  end

  def approve_all_requests
    weekly_plans = GradeSubject.where(approved: false)
    weekly_plans.each do |weekly_plan|
      weekly_plan.approved = true
      weekly_plan.save!
    end
    flash[:success] = "Approved all the weekly plans"
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_year_plan
      @year_plan = YearPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def year_plan_params
      params.require(:year_plan).permit(:year_name)
    end
end