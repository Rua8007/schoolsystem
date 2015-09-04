class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @categories = Category.all
    @departments = Department.all
    @positions = Position.all
  end

  # GET /employees/1/edit
  def edit
    @categories = Category.all
    @departments = Department.all
    @positions = Position.all
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        if @employee.category.name == 'Academic'
          u = User.new
          u.email = @employee.email
          u.password = '123'
          u.password_confirmation = '123'
          u.role = 'teacher'
          u.save
        end
        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_path, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_attendance_calendar
    @departments = Department.all
    @weekends = Weekend.all
  end

  ####### TIME ZONE ISSUES
  def mark_attendance
    if params[:attendance_date].present? && ( params[:attendance_date].to_date.strftime("%d-%m-%Y") === Date.today.strftime("%d-%m-%Y") || params[:attendance_date].to_date < Date.today ) && Weekend.find_by_weekend_day(params[:attendance_date].to_date.wday).nil?
      @attendance_date = params[:attendance_date].to_date.strftime("%d-%m-%Y")
      if params[:department].present?
        @department = params[:department]
        dept = Department.find(params[:department])
        if dept.present?
          dep_employees = dept.employees
          @dept_name = dept.name
          @emp_attendances = []
        end
      end
      if params[:attendance_date].to_date < Date.today

        if dep_employees.present?
          dep_employees.each_with_index do |emp, i|
            emp_att_leave = Leave.where("leave_from <= ? AND leave_to >= ? AND employee_id = ? AND approved = true ",params[:attendance_date].to_date,params[:attendance_date].to_date, emp.id).first

            emp_att_previous = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
             
            if emp_att_previous.present?
              @previous_attendance_edit = true
              att = emp_att_previous.epresent
            elsif emp_att_leave.present?
              att = false
            else
              att = true
            end

            emp_att = {
                        "emp_id" => "#{emp.id}",
                        "name" => "#{emp.full_name}", 
                        "position" => "#{emp.try(:position).try(:name)}",
                        "attendance" => "#{emp_att_leave.present? ? false : att }",
                        "leave" => "#{emp_att_leave.present? ? true : false }",
                        "reason" => "#{emp_att_leave.reason if emp_att_leave.present? }"
                      }
            @emp_attendances << emp_att

            if emp_att_previous.nil?
              @previous_attendance_edit = false
              flash[:notice] = "Previous Attendance Not Found. You may mark right now."
            end
          end
        end
      else
        if dep_employees.present?
          dep_employees.each_with_index do |emp, i|
            emp_att_leave = Leave.where("leave_from <= ? AND leave_to >= ? AND employee_id = ? AND approved = true",params[:attendance_date].to_date,params[:attendance_date].to_date, emp.id).first

            
            emp_att_previous = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
             
            if emp_att_previous.present?
              @previous_attendance_edit = true
              att = emp_att_previous.epresent
            elsif emp_att_leave.present?
              att = false
            else
              att = true
            end

            if emp_att_previous.present?
              emp_att = {
                          "emp_id" => "#{emp.id}",
                          "name" => "#{emp.full_name}", 
                          "position" => "#{emp.try(:position).try(:name)}",
                          "attendance" => "#{emp_att_leave.present? ? false : att }",
                          "leave" => "#{emp_att_leave.present? ? true : false }",
                          "reason" => "#{emp_att_leave.reason if emp_att_leave.present? }"
                        }
            else
              emp_att = { "emp_id" => "#{emp.id}",
                          "name" => "#{emp.full_name}", 
                          "position" => "#{emp.try(:position).try(:name)}",
                          "attendance" => "#{ emp_att_leave.nil? ? true : false }",
                          "leave" => "#{ emp_att_leave.present? ? true : false }",
                          "reason" => "#{emp_att_leave.reason if emp_att_leave.present? }"
                        }
            end
            @emp_attendances << emp_att
          end
        end
      end
    else
      flash[:alert] = "Future attendances/weekends can't be marked."
      redirect_to mark_attendance_calendar_employees_path
    end
  end

  def save_attendances
    # return render json: params.inspect
    if params[:attendance_date].present? && params[:attendance_date].to_date <= Date.today 
  

      old_attendance = EmployeeAttendance.where(attendance_date: params[:attendance_date].to_date).first
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
    redirect_to mark_attendance_calendar_employees_path
  end

  def monthly_attendance_report
    if current_user.role == 'teacher'
      @departments = Department.where(id: Employee.find_by_email(current_user.email).department_id)
    else
      @departments = Department.all
    end
  end

  def get_monthly_attendance_report_result
    if params[:department].present? && params[:month_year].present?
      month = params[:month_year].split('-').first
      year  = params[:month_year].split('-').last

      department = Department.find(params[:department].to_i)

      if department.present?
        @department_name = department.name
        employees = department.employees
        @attendances = []
        if current_user.role != 'teacher'
          employees.each_with_index do |employee, i|
            attendance = {}
            attendance.store("name","#{employee.full_name}")
            e_attendances = employee.employee_attendances.where("extract(month from attendance_date) = ? AND extract(year from attendance_date) = ?",month,year)
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
          employee = Employee.find_by_email(current_user.email)
          i = 0
          attendance = {}
          attendance.store("name","#{employee.full_name}")
          e_attendances = employee.employee_attendances.where("extract(month from attendance_date) = ? AND extract(year from attendance_date) = ?",month,year)
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

    return render partial: "employees/get_monthly_attendance_report_result"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def save_attendances_helper(params)
      if params[:department].present?
        
        dept = Department.find(params[:department])
        if dept.present?
          dep_employees = dept.employees
        end
        if dep_employees.present?
          dep_employees.each do |emp|
            emp_marked = false
            if params[:attendances].present?
              params[:attendances].each do |attendance|
                if emp.id == attendance.to_i
                  emp_attendance = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
                  if emp_attendance.nil?
                    emp_attendance = emp.employee_attendances.build(attendance_date: params[:attendance_date].to_date)
                  end
                  emp_attendance.epresent = true
                  emp_attendance.eleave = false
                  emp_attendance.save!
                  emp_marked = true
                else
                end
              end
            end
            if params[:leaves].present?
              params[:leaves].each do |leave|
                if emp.id == leave.to_i
                  emp_attendance = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
                  if emp_attendance.nil?
                    emp_attendance = emp.employee_attendances.build(attendance_date: params[:attendance_date].to_date, epresent: false, eleave: true)
                  end
                  emp_attendance.epresent = false
                  emp_attendance.eleave = true
                  emp_attendance.save!
                  emp_marked = true
                else
                end
              end
            else
              emp_leave = Leave.where("leave_from <= ? AND leave_to >= ? AND employee_id = ? AND approved = true",params[:attendance_date].to_date,params[:attendance_date].to_date, emp.id).first
            
              if emp_leave.present?
                emp_attendance = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
                if emp_attendance.nil?
                  emp_attendance = emp.employee_attendances.build(attendance_date: params[:attendance_date].to_date, epresent: false, eleave: true)
                end
                emp_attendance.epresent = false
                emp_attendance.eleave = true
                emp_attendance.save!
                emp_marked = true

              end
            end

            if emp_marked == false
              emp_attendance = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
              if emp_attendance.nil?
                emp_attendance = emp.employee_attendances.build(attendance_date: params[:attendance_date].to_date, epresent: false, eleave: false)
              end
              emp_attendance.epresent = false
              emp_attendance.eleave = false
              emp_attendance.save!
            end
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:employee_number, :date_of_joining, :full_name, :gender, :date_of_birth, :religion, :qualification, :category_id, :department_id, :marital_status, :child_count, :father_name, :mother_name, :spouse_name, :blood_group, :nationality, :id_card_no, :id_card_expiry, :address1, :address2, :city, :country, :home_phone, :mobile_number, :email, :salary, :position_id, :status, :pay_date, :next_due_date)
    end
end
