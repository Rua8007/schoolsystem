class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show, :edit, :update, :destroy]

  # GET /curriculums
  # GET /curriculums.json
  def index
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      @curriculums = @year_plan.curriculums
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
      @subjects = Subject.all
      @grades = Grade.all
    end
  end

  # GET /curriculums/1/edit
  def edit
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

          format.html { redirect_to @curriculum, notice: 'Curriculum was successfully created.' }
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
      format.html { redirect_to year_plans_url, notice: 'Curriculum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curriculum
      @curriculum = Curriculum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curriculum_params
      params.require(:curriculum).permit(:grade_id, :subject_id, :studentname)
    end
end
