class StudentsController < ApplicationController
	def index
		@students = Student.all
    @student = @students.first
	end

	def new
		@student = Student.new
	end

  def create
    @student = Student.create(create_params)
    if @student
      u = User.new
      u.email = @student.email
      u.password = '123'
      u.password_confirmation = '123'
      u.role = 'student'
      u.save
      emergency = @student.emergencies.create
      emergency.name = params[:student][:emergency][:name]
      emergency.mobile = params[:student][:emergency][:mobile]
      emergency.phone = params[:student][:emergency][:phone]
      emergency.email = params[:student][:emergency][:email]
      emergency.save

      fee = @student.fees.create
      fee.amount = params[:amount]
      fee.month = params[:month]
      fee.save

      redirect_to new_parent_path(student_id: @student.id), notice: "Student added"
    else
      redirect_to :back, :alert => "Fill the form again!"
    end
  end

  def edit
    @student = Student.find(params[:id])
    @edit = true

  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
      redirect_to students_path, notice: "Student Successfully updated"
      # Handle a successful update.
    else
      render 'edit'
    end
  end

    

  def edit_student
    @student = Student.find(params[:id])
    @edit = true

  end

  

  

  def assignParent
    # return render json: params
    std = Student.find(params[:id])
    std.parent_id = params[:student][:parent_id]
    std.save!
    redirect_to new_document_path(student_id: std.id)
  end

  def show
    @student = Student.find(params[:id])
    @parent = @student.parent
  end

  def detail
    puts "-"*80
    puts params
    puts "-"*80


    if params[:fee]
      if Student.find_by_id(params[:id]).present?
        @student = Student.find_by_id(params[:id])
      else
        @student = nil
      end
      respond_to do |format|
        format.json {render json: @student}
      end
    else
      respond_to do |format|
        format.js
        format.json { render json: {student: @student } }  # respond with the created JSON object
      end
    end
  end

  def mark_attendance_calendar
    @grades = Grade.all
    @weekends = Weekend.all
  end

  ####### TIME ZONE ISSUES
  def mark_attendance
    if params[:attendance_date].present? && ( params[:attendance_date].to_date.strftime("%d-%m-%Y") === Date.today.strftime("%d-%m-%Y") || params[:attendance_date].to_date < Date.today ) && Weekend.find_by_weekend_day(params[:attendance_date].to_date.wday).nil?
      @attendance_date = params[:attendance_date].to_date.strftime("%d-%m-%Y")
      if params[:grade].present?
        @grade = params[:grade]
        grad = Grade.find(params[:grade])
        if grad.present?
          grd_students = grad.students
          @grad_name = grad.name
          @std_attendances = []
        end
      end
      if params[:attendance_date].to_date < Date.today

        if grd_students.present?
          grd_students.each_with_index do |std, i|
            std_att_leave = StudentHoliday.where("leave_from <= ? AND leave_to >= ? AND student_id = ? AND approved = true ",params[:attendance_date].to_date,params[:attendance_date].to_date, std.id).first

            std_att_previous = std.student_attendances.where(attendance_date: params[:attendance_date].to_date).first
             
            if std_att_previous.present?
              @previous_attendance_edit = true
              att = std_att_previous.epresent
            elsif std_att_leave.present?
              att = false
            else
              att = true
            end

            std_att = {
                        "std_id" => "#{std.id}",
                        "name" => "#{std.fullname}", 
                        "grade" => "#{std.try(:grade).try(:name)}",
                        "attendance" => "#{std_att_leave.present? ? false : att }",
                        "leave" => "#{std_att_leave.present? ? true : false }",
                        "reason" => "#{std_att_leave.reason if std_att_leave.present? }"
                      }
            @std_attendances << std_att

            if std_att_previous.nil?
              @previous_attendance_edit = false
              flash[:notice] = "Previous Attendance Not Found. You may mark right now."
            end
          end
        end
      else
        if grd_students.present?
          grd_students.each_with_index do |std, i|
            std_att_leave = StudentHoliday.where("leave_from <= ? AND leave_to >= ? AND student_id = ? AND approved = true",params[:attendance_date].to_date,params[:attendance_date].to_date, std.id).first

            
            std_att_previous = std.student_attendances.where(attendance_date: params[:attendance_date].to_date).first
             
            if std_att_previous.present?
              @previous_attendance_edit = true
              att = std_att_previous.epresent
            elsif std_att_leave.present?
              att = false
            else
              att = true
            end

            if std_att_previous.present?
              std_att = {
                          "std_id" => "#{std.id}",
                          "name" => "#{std.fullname}", 
                          "grade" => "#{std.try(:grade).try(:name)}",
                          "attendance" => "#{std_att_leave.present? ? false : att }",
                          "leave" => "#{std_att_leave.present? ? true : false }",
                          "reason" => "#{std_att_leave.reason if std_att_leave.present? }"
                        }
            else
              std_att = { "std_id" => "#{std.id}",
                          "name" => "#{std.fullname}", 
                          "grade" => "#{std.try(:grade).try(:name)}",
                          "attendance" => "#{ std_att_leave.nil? ? true : false }",
                          "leave" => "#{ std_att_leave.present? ? true : false }",
                          "reason" => "#{std_att_leave.reason if std_att_leave.present? }"
                        }
            end
            @std_attendances << std_att
          end
        end
      end
    else
      flash[:alert] = "Future attendances/weekends can't be marked."
      redirect_to mark_attendance_calendar_students_path
    end
  end

  def save_attendances
    # return render json: params.inspect
    if params[:attendance_date].present? && params[:attendance_date].to_date <= Date.today 
  

      old_attendance = StudentAttendance.where(attendance_date: params[:attendance_date].to_date).first
      if old_attendance.present?
        if params[:edit_code].present? && params[:edit_code] == "120120120"
          save_attendances_helper(params)
          flash[:success] = "Successfully Marked Attendances."
        else
          flash[:alert] = "Error! Wrong Code."
        end
      else
        save_attendances_helper(params)
        flash[:success] = "Successfully Marked Attendances."
      end
    else
      flash[:alert] = "Couldn't mark attendances."
    end
    redirect_to mark_attendance_calendar_students_path
  end

  def monthly_attendance_report
    @grades = Grade.all
  end

  def get_monthly_attendance_report_result
    if params[:grade].present? && params[:month_year].present?
      month = params[:month_year].split('-').first
      year  = params[:month_year].split('-').last
      grade = Grade.find(params[:grade].to_i)

      if grade.present?
        @grade_name = grade.name
        students = grade.students
        @attendances = []
        if current_user.role != 'student'
          students.each_with_index do |student, i|
            attendance = {}
            attendance.store("name","#{student.fullname}")
            e_attendances = student.student_attendances.where("extract(month from attendance_date) = ? AND extract(year from attendance_date) = ?",month,year)
            if i == 0
              @total_working_days = e_attendances.count
            end
            e_attendances.each do |e_attendance|
              if e_attendance.epresent == true
                attendance.store("#{e_attendance.attendance_date.day}","P")
              elsif e_attendance.eleave == true
                attendance.store("#{e_attendance.attendance_date.day}","L")
              else
                attendance.store("#{e_attendance.attendance_date.day}","A")
              end
            end
            @attendances << attendance
          end
        else
          student = Student.find_by_email(current_user.email)
          i = 0 
          attendance = {}
          attendance.store("name","#{student.fullname}")
          e_attendances = student.student_attendances.where("extract(month from attendance_date) = ? AND extract(year from attendance_date) = ?",month,year)
          if i == 0
            @total_working_days = e_attendances.count
          end
          e_attendances.each do |e_attendance|
            if e_attendance.epresent == true
              attendance.store("#{e_attendance.attendance_date.day}","P")
            elsif e_attendance.eleave == true
              attendance.store("#{e_attendance.attendance_date.day}","L")
            else
              attendance.store("#{e_attendance.attendance_date.day}","A")
            end
          end
          @attendances << attendance
        end
      end
    end
    @month_year = params[:month_year]
    @weekends = Weekend.all
    @number_of_days = Date.civil(year.to_i, month.to_i, -1).day

    return render partial: "students/get_monthly_attendance_report_result"
  end

	private

    def create_params
      params.require(:student).permit(:fullname,:remote_image_url,:first_name, :mobile, :address, :email, :grade_id, :dob,:gender,:middle_name, :last_name, :blood, :birth_place, :nationality, :language, :religion, :city, :state, :country,:phone, :fee, :term, :due_date, :image,:iqamaNumber,:iqamaExpiry, :previousInstitute, :year, :totalMarks, :obtainedMarks, :forthname, :fifthname, :arabicname, :weight,:height,:eyeside,:hearing,:rh,:alergy,:nurology,:physical,:disability,:behaviour, emergencies_attributes:[:name, :phome, :mobile, :email, :student_id])      
    end

    def student_params
      params.require(:student).permit(:fullname,:remote_image_url,:first_name, :mobile, :address, :email, :grade_id, :dob,:gender,:middle_name, :last_name, :blood, :birth_place, :nationality, :language, :religion, :city, :state, :country,:phone, :fee, :term, :due_date, :image,:iqamaNumber,:iqamaExpiry, :previousInstitute, :year, :totalMarks, :obtainedMarks, :forthname, :fifthname, :arabicname, :weight,:height,:eyeside,:hearing,:rh,:alergy,:nurology,:physical,:disability,:behaviour, emergencies_attributes:[:name, :phome, :mobile, :email, :student_id])      
    end

    def save_attendances_helper(params)
      if params[:grade].present?
        
        grad = Grade.find(params[:grade])
        if grad.present?
          grd_students = grad.students
        end
        if grd_students.present?
          grd_students.each do |std|
            std_marked = false
            if params[:attendances].present?
              params[:attendances].each do |attendance|
                if std.id == attendance.to_i
                  std_attendance = std.student_attendances.where(attendance_date: params[:attendance_date].to_date).first
                  if std_attendance.nil?
                    std_attendance = std.student_attendances.build(attendance_date: params[:attendance_date].to_date)
                  end
                  std_attendance.epresent = true
                  std_attendance.eleave = false
                  std_attendance.save!
                  std_marked = true
                else
                end
              end
            end
            if params[:leaves].present?
              params[:leaves].each do |leave|
                if std.id == leave.to_i
                  std_attendance = std.student_attendances.where(attendance_date: params[:attendance_date].to_date).first
                  if std_attendance.nil?
                    std_attendance = std.student_attendances.build(attendance_date: params[:attendance_date].to_date, epresent: false, eleave: true)
                  end
                  std_attendance.epresent = false
                  std_attendance.eleave = true
                  std_attendance.save!
                  std_marked = true
                else
                end
              end
            else
              std_leave = StudentHoliday.where("leave_from <= ? AND leave_to >= ? AND student_id = ? AND approved = true",params[:attendance_date].to_date,params[:attendance_date].to_date, std.id).first
            
              if std_leave.present?
                std_attendance = std.student_attendances.where(attendance_date: params[:attendance_date].to_date).first
                if std_attendance.nil?
                  std_attendance = std.student_attendances.build(attendance_date: params[:attendance_date].to_date, epresent: false, eleave: true)
                end
                std_attendance.epresent = false
                std_attendance.eleave = true
                std_attendance.save!
                std_marked = true

              end
            end

            if std_marked == false
              std_attendance = std.student_attendances.where(attendance_date: params[:attendance_date].to_date).first
              if std_attendance.nil?
                std_attendance = std.student_attendances.build(attendance_date: params[:attendance_date].to_date, epresent: false, eleave: false)
              end
              std_attendance.epresent = false
              std_attendance.eleave = false
              std_attendance.save!
            end
          end
        end
      end
    end
end

