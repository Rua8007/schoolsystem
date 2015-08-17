class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.all
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
  end

  # GET /periods/new
  def new
    @period = Period.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.update(period_params)
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @period }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_daily_schedule
    @time_table = TimeTable.find(params[:time_table])
    @teacher = @time_table.employee
    @grade = @time_table.grade
    @subjects = Subject.all
    @weekends = Weekend.all
  end

  def save_daily_schedule
    # return render json: params.inspect

    @time_table = TimeTable.find(params[:time_table_id])
    weekends = Weekend.all
    max_count = 0
    success = true
    if @time_table.present?
      Date::DAYNAMES.each_with_index do |day,i|
        if weekends.find{ |w| w.weekend_day == i}.nil?
          if i == 0 
            max_count = params[day].count
          end
          if params[day].count == max_count
            params[day].each_with_index do |subj,j|
              if Subject.find(subj.to_i).present?
                @time_table.periods.create!(period_num: j, subject_id: subj.to_i, day: day)
              end
            end
          else
            success = false
          end
        end
      end
      if success == true
        flash[:success] = "Successfully saved Time Tables"
        redirect_to time_table_path(@time_table)
      else
        @time_table.destroy
        flash[:alert] = "Number of periods should be same of each day! Try again."
        redirect_to year_plans_path
      end
    else
      flash[:alert] = "Time Table not found"
      redirect_to time_tables_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:time_table_id, :period_num, :subject_id, :day)
    end
end
