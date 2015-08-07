class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :edit, :update, :destroy]

  # GET /weeks
  # GET /weeks.json
  def index
    # return render json: params.inspect
    @year_plan = YearPlan.find(params[:year_plan_id])
    if @year_plan.present?
      @weeks = @year_plan.weeks.sort_by &:start_date
      @grades = Grade.all
      @subjects = Subject.all
    end
  end

  # GET /weeks/1
  # GET /weeks/1.json
  def show
  end

  # GET /weeks/new
  def new
    @year_plan = YearPlan.find(params[:year_plan_id])
    max_week = @year_plan.weeks.count+1
    @week = Week.new(year_week_id: max_week)

  end

  # GET /weeks/1/edit
  def edit
    # return render json: params.inspect
    @year_plan = YearPlan.find(params[:year_plan_id])
  end

  # POST /weeks
  # POST /weeks.json
  def create
    # return render json: params.inspect
    @year_plan = YearPlan.find(params[:year_plan_id])
    if @year_plan.present?
      @week = @year_plan.weeks.build(week_params)
    end

    respond_to do |format|
      if @week.save
        @week.year_week_id = @year_plan.weeks.count
        @week.save!

        format.html { redirect_to year_plan_weeks_path(@year_plan.id), notice: 'Week was successfully created.' }
        format.json { render :show, status: :created, location: @week }
      else
        format.html { render :new }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weeks/1
  # PATCH/PUT /weeks/1.json
  def update
    @year_plan = YearPlan.find(params[:year_plan_id])
    respond_to do |format|
      if @week.update(week_params) && @year_plan.present?
        format.html { redirect_to year_plan_weeks_path(@year_plan.id), notice: 'Week was successfully updated.' }
        format.json { render :show, status: :ok, location: @week }
      else
        format.html { render :edit }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weeks/1
  # DELETE /weeks/1.json
  def destroy
    # return render json: params.inspect
    @week.destroy
    respond_to do |format|
      format.html { redirect_to year_plan_weeks_path(params[:year_plan_id]), notice: 'Week was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def schedule_weeks
    # return render json: params.inspect
    @subject = Subject.find(params[:subject_id])
    @grade = Grade.find(params[:grade_id])
    @year_plan = YearPlan.find(params[:year_plan_id])
    if @subject.present? && @grade.present? && @year_plan.present?
      # grade_subjects = GradeSubject.where(subject_id: @subject.id, grade_id: @grade.id)
      # @days
      @weeks = @year_plan.weeks.sort_by &:start_date
    end
  end

  def add_schedule_weeks
    year = YearPlan.find(params[:year_plan_id])
    subject = Subject.find(params[:subject])
    grade = Grade.find(params[:grade])
    if year.present? && subject.present? && grade.present?
      weeks = year.weeks.sort_by &:start_date
      weeks.each_with_index do |week,i|
        classworks = "classworks_"+i.to_s
        homeworks  = "homeworks_"+i.to_s
        params[classworks].each_with_index do |cw,day_num|
          day_name = "day_"+day_num.to_s
          week.grade_subjects.create!(subject_id: subject.id, grade_id: grade.id, dayname: day_name, classwork: params[classworks][day_num], homework: params[homeworks][day_num])
        end
      end
    end
    redirect_to year_plan_path(year)
  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week
      @week = Week.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def week_params
      params.require(:week).permit(:year_week_id, :start_date, :end_date, :holiday_description)
    end
end
