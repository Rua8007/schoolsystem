class PortionsController < ApplicationController
  before_action :set_portion, only: [:show, :edit, :update, :destroy]

  # GET /portions
  # GET /portions.json
  def index
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      @portions = @year_plan.portions
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
      @subjects = Subject.all
    end
  end

  # GET /portions/1/edit
  def edit
    @subjects = Subject.all
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

          format.html { redirect_to @portion, notice: 'Portion was successfully created.' }
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
      format.html { redirect_to year_plans_url, notice: 'Portion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portion
      @portion = Portion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portion_params
      params.require(:portion).permit(:year_plan_id, :quarter)
    end
end
