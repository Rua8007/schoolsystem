module PublishResultsHelper
  def get_report_card_urls(klass, batch)
    students = klass.students
    if students.present?
      students.each do |std|
        report_card = ReportCard.find_by(student_id: std.id, grade_id: klass.id, batch_id: batch.id)
        if report_card.present?
          report_card.update_attributes(
              quarter_result_url: result_card_url(std.id, klass.id, batch.id),
              final_result_url: complete_result_card_url(std.id, klass.id, batch.id)
          )
        end
      end
    end
  end

  def delete_report_card_urls(klass, batch)
    students = klass.students
    if students.present?
      students.each do |std|
        report_card = ReportCard.find_by(student_id: std.id, grade_id: klass.id, batch_id: batch.id)
        if report_card.present?
          report_card.update_attributes(
              quarter_result_url: '',
              final_result_url: ''
          )
        end
      end
    end
  end
end
