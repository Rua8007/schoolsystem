class ReportCardSettingsController < ApplicationController

  def new
    @setting = ReportCardSetting.new
    @grade = params[:grade_id].present? ? Grade.find(params[:grade_id]) : Grade.where(section: nil).order('name').first
    @exams = Exam.where(grade_id: @grade.id)
    @exam = params[:exam_id].present? ? Exam.find(params[:exam_id]) : @exams.first
  end

  def create
    @setting = ReportCardSetting.find_or_initialize_by(grade_id: setting_params[:grade_id], batch_id: setting_params[:batch_id], exam_id: setting_params[:exam_id])
    if @setting.new_record?
      @setting.report_type_id = setting_params[:report_type_id]
      if @setting.save
        redirect_to new_marks_divisions_path(@setting)
      else
        flash[:notice] = 'Some thing bad happened. Please try again.'
        redirect_to report_card_setting_new_path(@setting.grade_id, @setting.exam_id)
      end

    elsif @setting.report_type_id == setting_params[:report_type_id].to_i
      redirect_to new_marks_divisions_path(@setting)
    else
      flash[:notice] = 'Another report card exists with different report type.'
      redirect_to report_card_setting_new_path(@setting.grade_id, @setting.exam_id)
    end
  end

  def edit
  end

  def show
  end

  def new_marks_divisions
    @setting = ReportCardSetting.find(params[:id])
    @previous_setting = ReportCardSetting.where(grade_id: @setting.grade_id).try(:first)
    @setting.marks_divisions << @previous_setting.marks_divisions if @previous_setting.present? and @setting.marks_divisions.blank?
  end

  def create_marks_divisions
    @setting = ReportCardSetting.find(params[:id])
    if @setting.update(setting_params)
      redirect_to new_headings_path(@setting)
    else
      flash[:notice] = @setting.errors.full_messages
      redirect_to new_marks_divisions_path(@setting)
    end
  end

  def new_headings
    @setting = ReportCardSetting.find(params[:id])
    if @setting.headings.blank?
      Heading.all.each do |heading|
        @setting.headings << ReportCardHeading.new(label: '', method: heading.method, show: true)
      end
    end
  end

  def create_headings
    @setting = ReportCardSetting.find(params[:id])
    if @setting.update(setting_params)
      render json: @setting.headings.to_json
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
                                                marks_divisions_attributes: [:id, :name, :passing_marks, :total_marks, :is_divisible, :_destroy],
                                                headings_attributes: [:id, :label, :show])
  end

end
