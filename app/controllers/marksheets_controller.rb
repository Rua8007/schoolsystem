class MarksheetsController < ApplicationController
  before_action :set_marksheet, only: [:show, :edit, :update, :destroy, :upload]

  # GET /marksheets
  # GET /marksheets.json
  def index
    @marksheets = Marksheet.all
  end

  # GET /marksheets/1
  # GET /marksheets/1.json
  def show
  end

  # GET /marksheets/new
  def new
    @marksheet = Marksheet.new
  end

  # GET /marksheets/1/edit
  def edit
  end

  # POST /marksheets
  # POST /marksheets.json
  def create
    @marksheet = Marksheet.new(marksheet_params)

    respond_to do |format|
      if @marksheet.save
        format.html { redirect_to upload_marksheet_path(@marksheet.id), notice: 'Marksheet was successfully created.' }
        format.json { render :show, status: :created, location: @marksheet }
      else
        format.html { render :new }
        format.json { render json: @marksheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marksheets/1
  # PATCH/PUT /marksheets/1.json
  def update
    respond_to do |format|
      if @marksheet.update(marksheet_params)
        format.html { redirect_to @marksheet, notice: 'Marksheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @marksheet }
      else
        format.html { render :edit }
        format.json { render json: @marksheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marksheets/1
  # DELETE /marksheets/1.json
  def destroy
    @marksheet.destroy
    respond_to do |format|
      format.html { redirect_to marksheets_url, notice: 'Marksheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
    @students = @marksheet.bridge.grade.students
    @marks = @marksheet.bridge.grade.marks
  end

  def uploading
    params[:marks].each do |marks|
      marksheet = Marksheet.find(params[:marksheet])
      marksheet.student_id = marks.first
      std_marks = marksheet.student.grade.marks.all
      std_marks.each do |mark_type|
        sessional = marksheet.sessionals.create
        sessional.mark_id = mark_type.id
        sessional.marks = marks.last[mark_type.name]["number"]
        sessional.save
      end
      marksheet.save
    end
  end

  def classresult
  end

  def get_class_result
    @class = Grade.find(params[:class_id])
    @marksheet = []
    # @class.bridges.each do |b|
    #   if b.marksheets.find_by_exam_id(params[:exam_id]).present?
    #     @marksheet << b.marksheets.find_by_exam_id(params[:exam_id])
    #   end
    # end
    @class.students.each do |std|
      temp = []
      std.marksheets.where(exam_id: params[:exam_id]).each do |m|
        temp.push({subject: m.bridge.subject_id, marks: m.sessionals.sum(:marks)})
      end
      @marksheet.push({student_id: std.id ,marks: temp})

    end

    puts "-----"*80
    puts @marksheet.last.inspect 
    puts @marksheet.last[:student_id] 

    puts @marksheet.last[:marks].first[:marks].inspect 
    puts "-----"*80
    respond_to do |format|
      format.js
      format.json { render json: {marksheet: @marksheet} }
    end

    # return render json: @marksheet
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marksheet
      @marksheet = Marksheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marksheet_params
      params.require(:marksheet).permit(:exam_id, :bridge_id, :totalmarks, :obtainedmarks, :student_id)
    end
end
