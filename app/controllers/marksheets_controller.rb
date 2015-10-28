class MarksheetsController < ApplicationController
  before_action :set_marksheet, only: [:show, :edit, :update, :upload]

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
    if current_user.role.rights.where(value: "upload_marks").nil?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
    @marksheet = Marksheet.new
  end

  # GET /marksheets/1/edit
  def edit
  end

  # POST /marksheets
  # POST /marksheets.json
  def create
    @marksheet = Marksheet.new(marksheet_params)
    # if @marksheet.bridge.marksheets.where(exam_id: @marksheet.exam_id).any?
    #   redirect_to :back, alert: "You have already uploaded a Marksheet. Edit the existing one"
    # else
      respond_to do |format|
        if @marksheet.save
          format.html { redirect_to upload_marksheets_path({id: @marksheet.id}), notice: 'Marksheet was successfully created.' }
          format.json { render :show, status: :created, location: @marksheet }
        else
          format.html { render :new }
          format.json { render json: @marksheet.errors, status: :unprocessable_entity }
        end
      # end
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
    if current_user.role.rights.where(value: "upload_marks").nil?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
    @students = @marksheet.bridge.grade.students
    @marks = @marksheet.bridge.grade.marks
    @mark = @marks.first
    if params[:mark_id].present?
      @mark = Mark.find(params[:mark_id])
    end
    @data = Sessional.where("mark_id = ? and exam_id = ? and bridge_id = ?", @mark.id, @marksheet.exam_id, @marksheet.bridge_id).group_by {|p| p.mark_date}
    # return render json: @data
  end

  def uploading
    # return render json: params
    mdate = params[:marks_date]
    sessionals = []

    marksheet = Marksheet.find(params[:marksheet_id])

    all_date = params[:marks]
    unless all_date.nil?
      students = all_date.keys

      students.try(:each) do |std|
        all_date[std].zip(mdate).each do |m,d|
          temp = Sessional.new
          temp.student_id = std.to_i
          temp.exam_id = marksheet.exam_id
          temp.bridge_id = marksheet.bridge_id
          temp.mark_id = params[:mark_id]
          temp.mark_date = d
          temp.student_id = std
          temp.marks = m
          temp.save
        end
      end
    end

    update_data = params[:up_mark]
      # return render json: update_data

    unless update_data.nil?
      update_data.keys.try(:each) do |sess|
        temp = Sessional.find(sess)
        temp.marks = update_data[sess].to_f
        temp.save
      end
    end


    # marksheet = Marksheet.find(params[:marksheet])
    # std_marks = marksheet.bridge.grade.marks.all
    # params[:marks].each do |marks|
    #   new_marksheet = Marksheet.create
    #   new_marksheet.exam_id = marksheet.exam_id
    #   new_marksheet.bridge_id = marksheet.bridge_id
    #   new_marksheet.student_id = marks.first
    #   std_marks.each do |mark_type|
    #     sessional = new_marksheet.sessionals.create
    #     sessional.mark_id = mark_type.id
    #     sessional.marks = marks.last[mark_type.name]["number"]
    #     sessional.save
    #   end
    #   new_marksheet.save
    #   marksheet.delete
    # end
    redirect_to subject_result_marksheets_path
  end

  def classresult
    if current_user.role.rights.where(value: "view_class_result").nil?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
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
      @class.bridges.each do |bd|
        sessional = bd.sessionals.where("student_id = ? and exam_id = ?", std.id, @exam.id).sum(:marks)
        temp["#{bd.subject.name}"] = sessional
      end

      # @class.bridges.each do |bridge|
      #   marksheet = std.marksheets.where(exam: @exam, bridge: bridge).first

      #   if marksheet.blank?
      #     temp[bridge.subject_id] = 'No marksheet!'

      #   elsif marksheet.sessionals.any?
      #     temp[bridge.subject_id] = marksheet.sessionals.sum(:marks)

      #   else
      #     temp[bridge.subject_id] = 'Result Awaiting'
      #   end
      # end



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
    puts "===================="
    puts @marksheet
    puts "===================="

    respond_to do |format|
      format.js
      format.json { render json: {marksheet: @marksheet} }
    end

    # return render json: @marksheet
  end

  def edit_marks
    @student = Student.find(params[:student_id])
    marks = @student.grade.marks

    @marksheet = @student.marksheets.where("exam_id = ? and bridge_id = ?", params[:exam_id], params[:bridge_id]).first
    if @marksheet.present?
      @sessionals = @marksheet.sessionals
    else
      @sessionals = false
      @marksheet = Marksheet.new
      @marksheet.bridge_id = params[:bridge_id]
      @marksheet.exam_id = params[:exam_id]
      @marksheet.student_id = @student.id
      @marksheet.save
    end
    if !@sessionals
      puts "---------------------------"
      @marks = marks
    else
      @marks = marks.where.not(id: @sessionals.pluck(:mark_id))
    end
    # return render json: @sessionals
  end

  def update_marks

    if params[:sess].present?
      sess_ids = params[:sess].keys
      sess_ids.try(:each) do |id|
        s = Sessional.find(id)
        s.marks = params[:sess][id][:marks]
        s.save
      end
    end
    if params[:marks].present?
      marks_id = params[:marks].keys
      marks_id.try(:each) do |m|
        s = Marksheet.find(params[:marksheet_id]).sessionals.new
        s.marks = params[:marks][m][:marks] || 0
        s.save
      end
    end
    redirect_to subject_result_marksheets_path, notice: 'Marks Updated Successfully'
  end

  def result_card
    @std = Student.find(params[:student])
    @marks = @std.grade.marks
    @exam = Exam.find(params[:exam])
    @data = @std.sessionals.where(exam_id: params[:exam])
    @sessionals = []
    @std.grade.bridges.try(:each) do |bd|
      temp = []
      gsum = 0
      slist = @data.where(bridge_id: bd.id)
      @std.grade.marks.each do |mk|
        sum = slist.where(mark_id: mk.id).sum(:marks)
        if mk.name != "Quiz" && mk.name != "Evaluation"
          gsum = gsum+sum
        end
        temp << {"#{mk.name}": sum}
      end
      if temp.any?
        @sessionals << {"#{bd.subject.name}": temp, total: gsum}
      else
        @sessionals << {"#{bd.subject.name}": "N/A" , total: 0}
      end
    end

    # return render json: @sessionals
    # @marks = []
    # @sessionals = @std.grade.marks
    # marksheets = @std.marksheets.where(exam_id: params[:exam])
    # puts
    # @std.marksheets.where(exam_id: params[:exam]).each do |m|
    #   sessionals = m.sessionals
    #   @marks.push({subject: m.bridge.subject.name, sessionals: sessionals})
    # end
    # return render json: @data
  end

  def subject_result
    @bridges = Bridge.all
    if current_user.role.rights.where(value: "subject_result").nil?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
  end

  def get_subject_result
    bridge = Bridge.find(params[:bridge_id])
    @bridge_id = params[:bridge_id]
    @exam_id = params[:exam_id]
    @exam = Exam.find(@exam_id)
    @class = bridge.grade
    @marksheets = []

    @marksheet = @exam.sessionals.where(bridge_id: @bridge_id).group_by{|p| p.student_id}
    puts "---------------------------"
    puts @marksheet
    puts "---------------------------"

    respond_to do |format|
      format.js
      format.json { render json: {marksheet: @marksheet} }
    end
  end

  def result
    @std = Student.find(params[:student_id])
    # return render json: @marks
  end

  def destroy
    puts "=======================i am in destroy=============="
    marksheet = Marksheet.find(params[:marksheet_id])
    Sessional.where("bridge_id = ? and exam_id = ? and mark_date = ?", marksheet.bridge_id, marksheet.exam_id, params[:id]).delete_all
    puts marksheet

    puts "=======================i am in destroy=============="

    redirect_to :back
  end

  def student_marks_subject
    if current_user.role.name == 'Parent'
      student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @bridges = student.grade.bridges
      @exams = Exams.all
    else
      if current_user.role.name == 'Student'
        student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
        @bridges = student.grade.bridges
        @exams = Exams.all
      else
        redirect_to root_path, alert: "Sorry! You are not authorized"
      end
    end
  end

  def student_marks

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
