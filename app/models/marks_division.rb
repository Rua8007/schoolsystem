class MarksDivision < ActiveRecord::Base

  belongs_to :parent, class_name: 'MarksDivision'
  has_many :sub_divisions, foreign_key: 'parent_id', class_name: 'MarksDivision'

  accepts_nested_attributes_for :sub_divisions , reject_if: :all_blank, allow_destroy: true

  before_save :update_report_card
  before_destroy :destroy_marks

  def update_report_card
    grade_group = self.grade_group
    grade = Grade.find_by_grade_group_id(grade_group.id) if grade_group.present?
    setting = ReportCardSetting.find_by(grade_id: grade.id, batch_id: Batch.last.id) if grade.present?
    if setting.present?
      division = setting.marks_divisions.find_by(name: self.name)
      division.update(passing_marks: self.passing_marks, total_marks: self.total_marks, is_divisible: self.is_divisible)
    end
  end

  def destroy_marks
    grade_group = self.grade_group
    grade = Grade.find_by_grade_group_id(grade_group.id) if grade_group.present?
    setting = ReportCardSetting.find_by(grade_id: grade.id, batch_id: Batch.last.id) if grade.present?

    if setting.present?
      report_card_division = setting.marks_divisions.find_by(name: self.name)
      report_cards = ReportCard.where(setting_id: setting.id)
      if report_cards.present? and report_card_division.present?
        report_cards.each do |card|
          card.marks.where(division_id: report_card_division.id).destroy_all
        end
        report_card_division.destroy
      end
    end
  end

end
