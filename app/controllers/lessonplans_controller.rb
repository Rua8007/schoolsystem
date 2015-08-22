class LessonplansController < ApplicationController
  before_action :set_lessonplan, only: [:show, :edit, :update, :destroy]

  # GET /lessonplans
  # GET /lessonplans.json
  def index
    @year_plan = YearPlan.find(params[:year_plan])
    if @year_plan.present?
      @lessonplans = @year_plan.lessonplans
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
      @subjects = Subject.all
      @grades = Grade.all
    end
  end

  # GET /lessonplans/1/edit
  def edit
  end

  # POST /lessonplans
  # POST /lessonplans.json
  def create
    @year_plan = YearPlan.find(params[:lessonplan][:year_plan_id])

    if @year_plan.present?
      @lessonplan = @year_plan.lessonplans.build(lessonplan_params)

   respond_to do |format|
        if @lessonplan.save

          params[:lessonplan_detail_days].each_with_index do |detail_day,i|
            @lessonplan.lessonplan_details.create!(period: params[:lessonplan_detail_days][i], procedure: params[:lessonplan_detail_details][i])
          end

          format.html { redirect_to @lessonplan, notice: 'Portion was successfully created.' }
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
      format.html { redirect_to year_plans_url, notice: 'Lessonplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessonplan
      @lessonplan = Lessonplan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lessonplan_params
      params.require(:lessonplan).permit(:grade_id, :subject_id, :topic, :selection, :startdate, :enddate, :studentengage, :newvocabulary, :objectives,:year_plan_id)
    end
end
