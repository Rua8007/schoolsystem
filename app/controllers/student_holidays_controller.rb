class StudentHolidaysController < ApplicationController
  before_action :set_student_holiday, only: [:show, :edit, :update, :destroy]

  # GET /student_holidays
  # GET /student_holidays.json
  def index
    @student_holidays = StudentHoliday.all
  end

  # GET /student_holidays/1
  # GET /student_holidays/1.json
  def show
  end

  # GET /student_holidays/new
  def new
    @student_holiday = StudentHoliday.new
  end

  # GET /student_holidays/1/edit
  def edit
  end

  # POST /student_holidays
  # POST /student_holidays.json
  def create
    @student_holiday = StudentHoliday.new(student_holiday_params)

    respond_to do |format|
      if @student_holiday.save
        format.html { redirect_to @student_holiday, notice: 'Student holiday was successfully created.' }
        format.json { render :show, status: :created, location: @student_holiday }
      else
        format.html { render :new }
        format.json { render json: @student_holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_holidays/1
  # PATCH/PUT /student_holidays/1.json
  def update
    respond_to do |format|
      if @student_holiday.update(student_holiday_params)
        format.html { redirect_to @student_holiday, notice: 'Student holiday was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_holiday }
      else
        format.html { render :edit }
        format.json { render json: @student_holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_holidays/1
  # DELETE /student_holidays/1.json
  def destroy
    @student_holiday.destroy
    respond_to do |format|
      format.html { redirect_to student_holidays_url, notice: 'Student holiday was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_holiday
      @student_holiday = StudentHoliday.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_holiday_params
      params.require(:student_holiday).permit(:reason, :description, :student_id, :leave_from, :leave_to, :approved)
    end
end
