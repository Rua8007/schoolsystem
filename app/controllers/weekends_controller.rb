class WeekendsController < ApplicationController
  before_action :set_weekend, only: [:show, :edit, :update, :destroy]

  # GET /weekends
  # GET /weekends.json
  def index
    @weekends = Weekend.all
  end

  # GET /weekends/1
  # GET /weekends/1.json
  def show
  end

  # GET /weekends/new
  def new
    @weekend = Weekend.new
  end

  # GET /weekends/1/edit
  def edit
  end

  # POST /weekends
  # POST /weekends.json
  def create
    @weekend = Weekend.new(weekend_params)

    respond_to do |format|
      if @weekend.save
        format.html { redirect_to @weekend, notice: 'Weekend was successfully created.' }
        format.json { render :show, status: :created, location: @weekend }
      else
        format.html { render :new }
        format.json { render json: @weekend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekends/1
  # PATCH/PUT /weekends/1.json
  def update
    respond_to do |format|
      if @weekend.update(weekend_params)
        format.html { redirect_to @weekend, notice: 'Weekend was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekend }
      else
        format.html { render :edit }
        format.json { render json: @weekend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekends/1
  # DELETE /weekends/1.json
  def destroy
    @weekend.destroy
    respond_to do |format|
      format.html { redirect_to weekends_url, notice: 'Weekend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_weekends
    if params[:weekend].present?
      Date::DAYNAMES.each_with_index do |day,d|
        if params[:weekend].find{ |w| w == day }.present?
          weekend_day = Weekend.find_by_weekend_day(d)
          if !weekend_day.present?
            Weekend.create!(weekend_day: d)
          end
        else
          weekend_day = Weekend.find_by_weekend_day(d)
          if weekend_day.present?
            weekend_day.destroy
          end
        end
      end
    end
    flash[:success] = "Weekend Changed successfully"
    redirect_to mark_attendance_calendar_employees_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekend
      @weekend = Weekend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekend_params
      params.require(:weekend).permit(:weekend_day)
    end
end
