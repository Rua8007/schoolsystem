class TimeTablesController < ApplicationController
  before_action :set_time_table, only: [:edit, :update, :destroy]

  # GET /time_tables
  # GET /time_tables.json
  def index
    @time_tables = TimeTable.all
  end

  # GET /time_tables/1
  # GET /time_tables/1.json
  def show
    @time_table = TimeTable.find(params[:id])
    if @time_table.present?
      @teacher = @time_table.employee
      @grade = @time_table.grade
      @subjects = Subject.all
      @weekends = Weekend.all
      @periods = @time_table.periods

      week_day = nil
      Date::DAYNAMES.each_with_index do |day,i|
        if @weekends.find{ |w| w.weekend_day == i}.nil?
          week_day = day
        end
      end
      @total_periods = @time_table.periods.where(day: week_day.to_s).count

      if @total_periods >= @time_table.break_after_period.to_i
        @total_periods = @total_periods + 1
      end
      if @total_periods >= @time_table.prayer_after_period.to_i
        @total_periods = @total_periods + 1
      end
      puts "-----"*300
      # week_day
      puts @total_periods


    end
  end

  # GET /time_tables/new
  def new
    @time_table = TimeTable.new

    @grade = Grade.find(params[:grade_id].to_i)
    if @grade.present?
      @time_table.grade_id = params[:grade_id]
      @teachers = Employee.all
    end
  end

  # GET /time_tables/1/edit
  def edit
    @grade = Grade.find(params[:grade_id].to_i)
    if @grade.present?
      @teachers = Employee.all
    end
  end

  # POST /time_tables
  # POST /time_tables.json
  def create
    # return render json: params.inspect
    @time_table = TimeTable.new(time_table_params)

    respond_to do |format|
      if @time_table.save
        @time_table.grade_id = params[:grade]
        @time_table.save!
        format.html { redirect_to make_daily_schedule_periods_path(time_table: @time_table), notice: 'Time table was successfully created.' }
        format.json { render :show, status: :created, location: @time_table }
      else
        format.html { render :new }
        format.json { render json: @time_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_tables/1
  # PATCH/PUT /time_tables/1.json
  def update
    respond_to do |format|
      if @time_table.update(time_table_params)
        format.html { redirect_to @time_table, notice: 'Time table was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_table }
      else
        format.html { render :edit }
        format.json { render json: @time_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_tables/1
  # DELETE /time_tables/1.json
  def destroy
    @time_table.periods.destroy_all
    @time_table.destroy
    respond_to do |format|
      format.html { redirect_to year_plans_url, notice: 'Time table was successfully destroyed. Make a new one by selecting grade.' }
      format.json { head :no_content }
    end
  end

  def show_daily_schedule
    # return render json: params.inspect

    @time_table = TimeTable.where(grade_id: params[:grade_id]).first

    if @time_table.present?
      redirect_to time_table_path(@time_table)
    else
      redirect_to new_time_table_path(grade_id: params[:grade_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_table
      @time_table = TimeTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_table_params
      params.require(:time_table).permit(:grade_id, :employee_id, :break_after_period, :prayer_after_period)
    end
end
