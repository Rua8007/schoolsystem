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
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
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
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
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
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_attendance_calendar
    @employees = Employee.all
    @departments = Department.all

  end

  ####### TIME ZONE ISSUES
  def mark_attendance
    # return render json: params[:receive_email]
    if params[:attendance_date].present? && ( params[:attendance_date].to_date.strftime("%d-%m-%Y") === Date.today.strftime("%d-%m-%Y") || params[:attendance_date].to_date < Date.today )
      @attendance_date = params[:attendance_date].to_date.strftime("%d-%m-%Y")
      if params[:department].present?
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
            emp_att_leave = Leave.where("leave_from <= ? AND leave_to >= ? AND employee_id = ? ",params[:attendance_date].to_date,params[:attendance_date].to_date, emp.id).first

            emp_att_previous = emp.employee_attendances.where(attendance_date: params[:attendance_date].to_date).first
            
            if emp_att_previous.present?
              att = emp_att_previous.epresent
            elsif emp_att_leave.present?
              att = false
            else
              att = true
            end

            emp_att = { "emp_id" => "#{emp.id}",
                        "name" => "#{emp.full_name}", 
                        "position" => "#{emp.try(:position).try(:name)}",
                        "attendance" => "#{att}",
                        "leave" => "#{emp_att_leave.present? ? true : false }",
                        "reason" => "#{emp_att_leave.reason if emp_att_leave.present? }"

                      }
            @emp_attendances << emp_att
          end
        end
      else
        if dep_employees.present?
          dep_employees.each_with_index do |emp, i|
            emp_att_leave = Leave.where("leave_from <= ? AND leave_to >= ? AND employee_id = ? ",params[:attendance_date].to_date,params[:attendance_date].to_date, emp.id).first

            emp_att = { "emp_id" => "#{emp.id}",
                        "name" => "#{emp.full_name}", 
                        "position" => "#{emp.try(:position).try(:name)}",
                        "attendance" => "#{ emp_att_leave.nil? ? true : false }",
                        "leave" => "#{ emp_att_leave.present? ? true : false }",
                        "reason" => "#{emp_att_leave.reason if emp_att_leave.present? }"

                      }
            @emp_attendances << emp_att
          end
        end
      end
    else
      flash[:alert] = "Future attendances can't be marked."
      redirect_to mark_attendance_calendar_employees_path
    end
  end

  def save_attendaces

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:employee_number, :date_of_joining, :full_name, :gender, :date_of_birth, :religion, :qualification, :category_id, :department_id, :marital_status, :child_count, :father_name, :mother_name, :spouse_name, :blood_group, :nationality, :id_card_no, :id_card_expiry, :address1, :address2, :city, :country, :home_phone, :mobile_number, :email, :salary, :position_id, :status, :pay_date, :next_due_date)
    end
end
