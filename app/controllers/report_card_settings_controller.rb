class ReportCardSettingsController < ApplicationController

  def new
    @setting = ReportCardSetting.new
    grade = Grade.where(section: nil).order('name').first
    @exams = Exam.where(grade_id: grade.id)
  end

  def create
    @setting = ReportCardSetting.find_or_initialize_by(grade_id: setting_params[:grade_id], batch_id: setting_params[:batch_id], exam_id: setting_params[:exam_id])
    if @setting.new_record?
      @setting.report_type_id = setting_params[:report_type_id]
      if @setting.save
        redirect_to new_marks_divisions_path(@setting)
      else
        flash[:notice] = 'Some thing bad happened. Please try again.'
        redirect_to new_report_card_setting_path
      end

    elsif @setting.report_type_id == setting_params[:report_type_id].to_i
      redirect_to new_marks_divisions_path(@setting)
    else
      flash[:notice] = 'Another report card exists with different report type.'
      redirect_to new_report_card_setting_path
    end
  end

  def edit
  end

  def show
  end

  def new_marks_divisions
    @setting = ReportCardSetting.find(params[:id])
  end

  def create_marks_divisions
    @setting = ReportCardSetting.find(params[:id])
    if @setting.update(setting_params)
      render json: @setting.marks_divisions.to_json
    else
      flash[:notice] = @setting.errors.full_messages
      redirect_to new_marks_divisions_path(@setting)
    end

  end

  def get_grade_exams
    grade = Grade.find(params[:grade_id])
    exams = Exam.where(grade_id: grade.id).order('name')

    render json: {exams: exams}
  end

  private

  def setting_params
    params.require(:report_card_setting).permit(:grade_id, :batch_id, :exam_id, :report_type_id,
                                                marks_divisions_attributes: [:id, :name, :passing_marks, :total_marks, :is_divisible, :_destroy])
  end

end
