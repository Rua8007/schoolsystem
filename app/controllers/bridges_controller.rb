class BridgesController < ApplicationController
  before_action :set_bridge, only: [:show, :edit, :update, :destroy]

  # GET /bridges
  # GET /bridges.json
  def index
    @bridges = Bridge.all
    @subjects = Subject.all
    @employees = Employee.all
  end

  # GET /bridges/1
  # GET /bridges/1.json
  def show
  end

  # GET /bridges/new
  def new
    @employee=Employee.all.order(:full_name).pluck(:full_name,:id)
    @bridge = []
    @grade = Grade.find(params[:class_id])
    main_grade = @grade.parent if @grade.present?

    main_grade.associations.try(:each) do |s|
      bridge = Bridge.find_by(subject_id: s.subject_id, grade_id: @grade.id)
      temp = {flag: false, subject_id: s.subject_id, employee_id: @employee, class_id: params[:class_id] } if bridge.nil?
      @bridge << temp if temp.present?
    end
    # @bridge.each do |b|
    #   puts "-"*80
    #   # puts b["flag"]
    # end
  end

  # GET /bridges/1/edit
  def edit
    @employee = Category.where(name: 'Academic').first.employees
  end

  def newassign
    @grade = Grade.find(params[:grade_id])
    @bridge = @grade.bridges.new
    @subjects = []
    Grade.where(section: nil).find_by_name(@grade.name).associations.try(:each) do |a|
      @subjects << a.subject
    end
    @employees = Employee.all

  end

  def assigned
    b = Bridge.new
    b.grade_id = params[:grade_id]
    b.subject_id = params[:subject_id]
    b.employee_id = params[:employee_id]
    b.save
    redirect_to  grades_path({grade_name: Grade.find(params[:grade_id]).name})
  end

  # POST /bridges
  # POST /bridges.json
  def create
    @bridge = Bridge.new(bridge_params)

    respond_to do |format|
      if @bridge.save
        format.html { redirect_to @bridge, notice: 'Bridge was successfully created.' }
        format.json { render :show, status: :created, location: @bridge }
      else
        format.html { render :new }
        format.json { render json: @bridge.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_teacher
    # return render json: params
    data = params[:flags]
    data.each_with_index do |flag , i|
      # x = i.to_s
      # my_loop= flag[i]
      if flag.last["check"].present?
        b = Bridge.new
        b.grade_id = params[:grade_id]
        b.subject_id = Subject.find_by_name(flag.last["subject_id"]).id
        b.employee_id = flag.last["teacher_id"]
        b.save
      end
    end
    redirect_to add_students_grade_path(params[:grade_id]), notice: "Teacher Assignments Done Successfully...!!!"
  end

  # PATCH/PUT /bridges/1
  # PATCH/PUT /bridges/1.json
  def update
    puts
    puts params.inspect
    puts
    respond_to do |format|
      if @bridge.update(bridge_params)
        return render json: @bridge
        format.html { redirect_to grade_path(@bridge.grade_id), notice: 'Bridge was successfully updated.' }
        format.json { render :show, status: :ok, location: @bridge }
      else
        format.html { render :edit }
        format.json { render json: @bridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bridges/1
  # DELETE /bridges/1.json
  def destroy
    @bridge.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Bridge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def class_subject
    @bridges = Grade.find(params[:id]).bridges
    @class = Grade.find(params[:id])
  end

  def teacher_subject
    employee = Employee.find_by_email(current_user.email)
    @bridges = employee.bridges
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bridge
      @bridge = Bridge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bridge_params
      params.require(:bridge).permit(:subject_id, :grade_id, :employee_id)
    end
end
