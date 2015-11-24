class ReportCardDivision < ActiveRecord::Base
  def self.find_by_marks_division(division)
    report_card_division = find_by name: division.name
    report_card_division.update(total_marks: division.total_marks, passing_marks: division.passing_marks) unless division.total_marks == report_card_division.total_marks and division.passing_marks == report_card_division.passing_marks
    report_card_division
  end
end
