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
    @setting = ReportCardSetting.find(params[:id])
    @grade = @setting.grade.present? ? @setting.grade : Grade.where(section: nil).order('name').first
    @exams = Exam.where(grade_id: @grade.id)
    @exam = @setting.exam.present? ? @setting.exam : @exams.first
  end

  def show
    @setting = ReportCardSetting.find(params[:id])
  end

  def destroy
    @setting = ReportCardSetting.find(params[:id])
    @exam = Exam.find(@setting.exam_id)
    @report_cards = ReportCard.where(setting_id: @setting.id)
    @report_cards.destroy_all
    @exam.destroy
    @setting.destroy

    flash[:notice] = 'Request Processed Successfully.'

    redirect_to select_report_card_path

  end

  def new_marks_divisions
    @setting = ReportCardSetting.find(params[:id])
    @previous_setting = ReportCardSetting.where(grade_id: @setting.grade_id, batch_id: Batch.last.id).try(:first)
    if @previous_setting.present? and @setting.marks_divisions.blank?
      @previous_setting.marks_divisions.try(:each) do |division|
        @setting.marks_divisions << ReportCardDivision.create(name: division.name, passing_marks: division.passing_marks, total_marks: division.total_marks, is_divisible: division.is_divisible)
      end
    end
  end

  def create_marks_divisions
    @setting = ReportCardSetting.find(params[:id])
    if @setting.update(setting_params)
      unless @setting.marks_divisions.where(name: "Exam Comments").any?
        exam_comment = @setting.marks_divisions.new({name: "Exam Comments", is_divisible: false})
        exam_comment.save!
      end
      redirect_to new_headings_path(@setting)
    else
      flash[:notice] = @setting.errors.full_messages
      redirect_to new_marks_divisions_path(@setting)
    end
  end

  def new_headings
    @setting = ReportCardSetting.find(params[:id])
      Heading.all.each do |heading|
        @setting.headings.find_or_create_by(method: heading.method)
      end
  end

  def create_headings
    @setting = ReportCardSetting.find(params[:id])
    if @setting.update(setting_params)
      redirect_to new_subjects_path(@setting)
    else
      flash[:notice] = @setting.errors.full_messages
      redirect_to new_marks_divisions_path(@setting)
    end
  end

  def new_subjects
    @setting = ReportCardSetting.find(params[:id])
    @grade = @setting.grade
    @subjects = []
    @grade.associations.try(:each) do |bridge|
      if bridge.subject.present?
        @subjects << bridge.subject if bridge.subject.present?
        @setting.subjects.find_or_create_by(name: bridge.subject.name, code: bridge.subject.code)
      end
    end
    @report_card_subjects = @setting.subjects.where(parent: nil)
  end

  def get_weightage
    @setting = ReportCardSetting.find(params[:id])
    @subject = ReportCardSubject.find_by_id(params[:subject_id]) || @setting.subjects.build
    if @subject.new_record?
       if @subject.save
          subject_ids = params[:subjects]
          subject_ids.each do |id|
            subject = ReportCardSubject.find(id)
            subject.update(parent_id: @subject.id)

            if params[:take_exam].present?
              if params[:take_exam].include? subject.id
                subject.update(parent_id: @subject.id, take_exam: true)
              else
                subject.update(parent_id: @subject.id, take_exam: false)
              end
            end
          end
       end
    end
  end

  def create_subjects
    puts "==========++++++++++================="
    puts "==========================="
    puts params.inspect
    puts "==========================="
    puts "==========================="
    @setting = ReportCardSetting.find(params[:id])
    if @setting.update(setting_params)
      redirect_to new_subjects_path(@setting)
    else
      flash[:notice] = @setting.errors.full_messages
      redirect_to new_subjects_path(@setting)
    end
  end

  def delete_subject_group
    @subject = ReportCardSubject.find(params[:id])
    @setting = @subject.setting
    if @subject.destroy
      flash[:notice] = 'Group Deleted Successfully.'
    end
    redirect_to new_subjects_path(@setting)
  end

  def select_report_card_setting
    @grades = Grade.where(section: nil).order('name')
  end


  private

  def setting_params
    params.require(:report_card_setting).permit(:grade_id, :batch_id, :exam_id, :report_type_id,
                                                marks_divisions_attributes: [:id, :name, :passing_marks, :total_marks, :is_divisible, :_destroy],
                                                headings_attributes: [:id, :label, :show, :color],
                                                subjects_attributes: [:id, :name, :code,
                                                  sub_subjects_attributes: [:id, :name, :code, :weight, :parent_id, :setting_id, :_destroy, :take_exam]
                                                ])
  end

end
