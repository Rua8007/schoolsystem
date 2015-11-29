class GradeGroupsController < ApplicationController
  before_action :set_grade_group, only: [:show, :edit, :update, :destroy]

  # GET /grade_groups
  # GET /grade_groups.json
  def index
    @grade_groups = GradeGroup.all
  end

  # GET /grade_groups/1
  # GET /grade_groups/1.json
  def show
  end

  # GET /grade_groups/new
  def new
    @grade_group = GradeGroup.new
  end

  # GET /grade_groups/1/edit
  def edit
  end

  # POST /grade_groups
  # POST /grade_groups.json
  def create
    @grade_group = GradeGroup.new(grade_group_params)

    respond_to do |format|
      if @grade_group.save
        format.html { redirect_to @grade_group, notice: 'Grade group was successfully created.' }
        format.json { render :show, status: :created, location: @grade_group }
      else
        format.html { render :new }
        format.json { render json: @grade_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grade_groups/1
  # PATCH/PUT /grade_groups/1.json
  def update
    respond_to do |format|
      if @grade_group.update(grade_group_params)
        format.html { redirect_to @grade_group, notice: 'Grade group was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade_group }
      else
        format.html { render :edit }
        format.json { render json: @grade_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_groups/1
  # DELETE /grade_groups/1.json
  def destroy
    @grade_group.destroy
    respond_to do |format|
      format.html { redirect_to grade_groups_url, notice: 'Grade group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade_group
      @grade_group = GradeGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_group_params
      params.require(:grade_group).permit(:name, marks_divisions_attributes: [:id, :name, :passing_marks, :total_marks, :is_divisible, :_destroy,
                                                 sub_divisions_attributes: [:id, :name, :total_marks, :_destroy]
                                                 ])
    end

    def build_associations
      @grade_group.marks_divisions.build unless @grade_group.marks_divisions.present?
    end
end
