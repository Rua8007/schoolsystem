class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  # GET /grades
  # GET /grades.json
  def index
    @grades = Grade.all

  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
    @batch = Batch.all.pluck(:name, :id)
    @batches=Batch.all
  end

  # GET /grades/1/edit
  def edit
    @batches=Batch.all
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)

    
      if @grade.save
        redirect_to new_bridge_path(class_id: @grade.id), notice: "Class Added Successfully"
     
    end
  end

  def all_student
    @grade = Grade.find(params[:id])
    @students = @grade.students
    @student = @students.first
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to grades_path, notice: 'Grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:name, :section, :batch_id)
    end
end
