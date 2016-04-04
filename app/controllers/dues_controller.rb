class DuesController < ApplicationController
  # before_action :set_due, only: [:show, :edit, :update, :destroy]

  # GET /dues
  # GET /dues.json
  def index
    @dues = Due.all
  end

  # GET /dues/1
  # GET /dues/1.json
  def show
  end

  # GET /dues/new
  def new
    @due = Due.new
  end

  # GET /dues/1/edit
  def edit
  end

  # POST /dues
  # POST /dues.json
  def create
    @due = Due.new(due_params)

    respond_to do |format|
      if @due.save
        format.html { redirect_to @due, notice: 'Due was successfully created.' }
        format.json { render :show, status: :created, location: @due }
      else
        format.html { render :new }
        format.json { render json: @due.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dues/1
  # PATCH/PUT /dues/1.json
  def update
    respond_to do |format|
      if @due.update(due_params)
        format.html { redirect_to @due, notice: 'Due was successfully updated.' }
        format.json { render :show, status: :ok, location: @due }
      else
        format.html { render :edit }
        format.json { render json: @due.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dues/1
  # DELETE /dues/1.json
  def destroy
    @due.destroy
    respond_to do |format|
      format.html { redirect_to dues_url, notice: 'Due was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_student
    @students = []
    if params[:name].present?
      @students = @students + Student.where('fullname LIKE ?', "%#{params[:name]}%").try(:order, 'fullname')
    end

    if params[:rollnumber].present?
      @students = @students + Student.where('rollnumber = ?', params[:rollnumber]).try(:order, 'fullname')
    end

    if params[:mobile].present?
      @students = @students +  Student.where('mobile = ?', params[:mobile]).try(:order, 'fullname')
    end

    if params[:grade_id].present?
      @students = @students +  Student.where('grade_id = ?', params[:grade_id]).try(:order, 'fullname')
    end

  end

  def create_fee_plan
    @student = Student.find(params[:student_id]) if params[:student_id].present?
    @main_grade = @student.grade.parent
    @fee_entries = FeeEntry.where(grade_id: @main_grade.id)
    @fee_entries.each do |fee_entry|
      Due.find_or_create_by(student_id: @student.id, feeable: fee_entry, grade_id: @main_grade.id)
    end
  end

  def save_fee_plan
    @student = Student.find(params[:student][:id])
    if @student.update(student_params)
      redirect_to create_fee_plan_path(@student), notice: 'Fee Plan Saved Successfully'
    else
      redirect_to create_fee_plan_path(@student), notice: 'Sorry Something Bad Happened.'
    end

  end

  def give_estimate
    @student  = Student.new(temporary: true)
    @grades   = Grade.where(section: nil).order('name')
    @grade    = params[:grade_id].present? ? Grade.find(params[:grade_id]) : @grades.first

    @fee_entries = FeeEntry.where(grade_id: @grade.id)
    @fee_entries.each do |fee_entry|
      @student.dues.build(grade_id: @grade.id, feeable: fee_entry, paid: 0, balance: fee_entry.total_amount)
    end
  end

  def save_temporary_student
    @student = Student.new student_params
    @student.temporary = true
    @student.rollnumber = "Std#{Student.where(temporary: true).length + 1}"
    if @student.save
      redirect_to give_estimate_path, notice: 'Fee Plan Saved Successfully'
    else
      puts '========================================'
      puts "Error: #{@student.errors.full_messages}"
      puts '========================================'
      redirect_to give_estimate_path, notice: 'Sorry Something Bad Happened.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_due
      @due = Due.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def due_params
      params.require(:due).permit(:feeable, :mode_id, :total, :paid, :balance, :discount, :student_id, :grade_id)
    end

    def student_params
      params.require(:student).permit(:id, :grade_id, :fullname, :email, dues_attributes: [:id, :show, :mode_id, :total, :paid, :balance, :feeable_id, :feeable_type, :grade_id])
    end
end
