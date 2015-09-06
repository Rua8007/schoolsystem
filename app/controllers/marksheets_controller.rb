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
    marksheet = Marksheet.find(params[:marksheet])
    std_marks = marksheet.bridge.grade.marks.all
    params[:marks].each do |marks|
      new_marksheet = Marksheet.create
      new_marksheet.exam_id = marksheet.exam_id
      new_marksheet.bridge_id = marksheet.bridge_id
      new_marksheet.student_id = marks.first
      std_marks.each do |mark_type|
        sessional = new_marksheet.sessionals.create
        sessional.mark_id = mark_type.id
        sessional.marks = marks.last[mark_type.name]["number"]
        sessional.save
      end
      new_marksheet.save
      marksheet.delete
    end
    redirect_to subject_result_marksheets_path
  end

  def classresult
  end

  def get_class_result
    @class = Grade.find(params[:class_id])
    @marksheet = []
    @exam = Exam.find(params[:exam_id])
    # @class.bridges.each do |b|
    #   if b.marksheets.find_by_exam_id(params[:exam_id]).present?
    #     @marksheet << b.marksheets.find_by_exam_id(params[:exam_id])
    #   end
    # end
    @class.students.each do |std|
      temp = {}

      @class.bridges.each do |bridge|
        marksheet = std.marksheets.where(exam: @exam, bridge: bridge).first

        if marksheet.blank?
          temp[bridge.subject_id] = 'No marksheet!'

        elsif marksheet.sessionals.any?
          temp[bridge.subject_id] = marksheet.sessionals.sum(:marks)
        
        else
          temp[bridge.subject_id] = 'Result Awaiting'
        end
      end
      # subjects = std.

      # std.marksheets.where(exam_id: params[:exam_id]).each do |m|
      #   if m.sessionals.any?
      #     temp.push({subject: m.bridge.subject_id, marks: m.sessionals.sum(:marks)})
      #   else
      #     temp.push({subject: m.bridge.subject_id, marks: 'Result Awaiting'})
      #   end
      # end
      @marksheet.push({student_id: std.id, marks: temp})
    end

    respond_to do |format|
      format.js
      format.json { render json: {marksheet: @marksheet} }
    end

    # return render json: @marksheet
  end

  def result_card
    @std = Student.find(params[:student])
    @marks = []
    @sessionals = @std.grade.marks
    marksheets = @std.marksheets.where(exam_id: params[:exam])
    puts 
    @std.marksheets.where(exam_id: params[:exam]).each do |m|
      sessionals = m.sessionals
      @marks.push({subject: m.bridge.subject.name, sessionals: sessionals})
    end
    # return render json: @marks.first[:sessionals]
  end

  def subject_result
    @bridges = Bridge.all
  end

  def get_subject_result
    bridge = Bridge.find(params[:bridge_id])
    @class = bridge.grade
    @marksheets = []
    
    @class.students.each do |std|
      temp = []
      if std.marksheets.where(exam_id: params[:exam_id], bridge_id: params[:bridge_id]).any?
        sessionals = std.marksheets.where(
          exam_id: params[:exam_id], 
          bridge_id: params[:bridge_id]
        ).last.sessionals

        temp2 = {}
        sessionals.each {|s| temp2[s.mark_id] = s}       
        sessionals = temp2
      # else
        # sessionals = ["Resutl Awaiting", "Resutl Awaiting", "Resutl Awaiting"]
      end
      
      @marksheets.push({student_id: std.id, student_name: std.fullname, sessionals: sessionals})
    end

    respond_to do |format|
      format.js
      format.json { render json: {marksheet: @marksheet} }
    end
  end

  def result
    @std = Student.find(params[:student_id])
    @marks = []
    # Exam.all.each do |exam|
    #   @std.grade.bridges.each do |bridge|
    #     temp = bridge.marksheets.where(exam_id: exam.id, student_id: @std.id)
    #     marks = {subject: bridge.subject.name, marks: temp}
    #   end
    #   # temp = {exam: exam, marks: marks}
    # end
    @std.grade.bridges.each do |bridge|
      exam_result = []
      Exam.all.each do |exam|
        if bridge.marksheets.where(exam_id: exam.id).any?
          temp = bridge.marksheets.where(exam_id: exam.id).first.sessionals.sum(:marks)
          exam_result << {exam: exam.name , result: temp}
        else
          exam_result << {exam: exam.name , result: 0}
        end
      end
      @marks << {subject: bridge.subject.name, marks: exam_result}
    end
    # return render json: @marks
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
