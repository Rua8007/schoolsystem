class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    unless current_user.role.rights.where(value: "view_exam").any?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
    @exams = Exam.order('name')
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  def lockexams
    unless current_user.role.rights.where(value: "lock_exams").any?
      redirect_to root_path, alert: "You are not authorized...!!!"
    else
      @exams = Batch.last.exams.order(:grade_id).group_by{|p| p.grade_id}
    end
  end

  def exam_locking
    exam_ids = params[:checked_exams]

    if params[:commit] == 'Lock'
      exam_ids.each do |exam_id|
        Exam.find(exam_id).update(is_locked: true)
      end
    elsif params[:commit] == 'Un-Lock'
      exam_ids.each do |exam_id|
        Exam.find(exam_id).update(is_locked: false)
      end
    end
    redirect_to :back, notice: "Exams status updated successfully..!!!"
  end

  # GET /exams/new
  def new
    unless current_user.role.rights.where(value: "create_exam").any?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
    unless current_user.role.rights.where(value: "update_exam").any?
      redirect_to :back, alert: "Sorry! You are not authorized"
    end
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        flash[:notice] = 'Exam was successfully created.'
        format.html { redirect_to report_card_setting_new_path(@exam.grade_id, @exam.id) }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        @setting = ReportCardSetting.find_by(exam_id: @exam.id)
        format.html { redirect_to edit_report_card_setting_path(@setting), notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to select_report_card_path, notice: 'Request Processed Successfully.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:name, :batch_id, :start_date, :end_date, :grade_id)
    end
end
