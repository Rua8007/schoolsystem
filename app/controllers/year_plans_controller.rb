class YearPlansController < ApplicationController
  before_action :set_year_plan, only: [:show, :edit, :update, :destroy]

  # GET /year_plans
  # GET /year_plans.json
  def index
    @year_plans = YearPlan.all
  end

  # GET /year_plans/1
  # GET /year_plans/1.json
  def show
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
        format.html { redirect_to year_plans_path, notice: 'Year plan was successfully created.' }
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
        format.html { redirect_to year_plans_path, notice: 'Year plan was successfully updated.' }
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
      format.html { redirect_to year_plans_url, notice: 'Year plan was successfully destroyed.' }
      format.json { head :no_content }
    end
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
