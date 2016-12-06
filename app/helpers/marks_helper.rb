module MarksHelper

  def get_employee_bridges(current_user)
    bridges = []
    grades = Grade.where(section: nil).order('name')
    if current_user.role.rights.where(value: 'enter_all_marks').any?
      grades.each do |grade|
        subgrades = Grade.where('name=? AND section IS NOT NULL', grade.name).order('section')
        subgrades.each do |sub_grade|
          bridge = Bridge.where(grade_id: sub_grade.id).try(:first)
          bridges << bridge if bridge.present?
        end
      end
    else
      grades.each do |grade|
        subgrades = Grade.where('name=? AND section IS NOT NULL', grade.name).order('section')
        subgrades.each do |sub_grade|
          bridge = Bridge.where(grade_id: sub_grade.id, employee_id: (Employee.find_by_email(current_user.email) || current_user).id ).try(:first)
          bridges << bridge if bridge.present?
        end
      end
    end
    bridges
  end

  def get_grade_bridges(current_user, grade_id)
    if current_user.role.rights.where(value: 'enter_all_marks').any?
      bridges = Bridge.where(grade_id: grade_id)
    else
      bridges = Bridge.where(grade_id: grade_id, employee_id: (Employee.find_by_email(current_user.email) || current_user).id )
    end
    bridges
  end

  def check_marks_divisions(setting, marks_divisions)
    if marks_divisions.present?
      if setting.marks_divisions.present?
        marks_divisions.each do |division|
          if setting.marks_divisions.where(name: division.name).blank?
            setting.marks_divisions << ReportCardDivision.new(name: division.name, total_marks: division.total_marks, passing_marks: division.passing_marks, is_divisible: division.is_divisible)
          else
            s = setting.marks_divisions.find_by(name: division.name)
            s.update(total_marks: division.total_marks, passing_marks: division.passing_marks, is_divisible: division.is_divisible)
          end
        end
      else
        marks_divisions.each do |division|
          setting.marks_divisions << ReportCardDivision.new(name: division.name, total_marks: division.total_marks, passing_marks: division.passing_marks, is_divisible: division.is_divisible)
        end
      end
    end
  end

  def check_subjects(setting, subjects)
    if subjects.present?
      if setting.subjects.present?
        subjects.each do |subject|
          if setting.subjects.where(name: subject.name, code: subject.code).blank?
            setting.subjects << ReportCardSubject.new(name: subject.name, code: subject.code)
          end
        end
      else
        subjects.each do |subject|
          setting.subjects << ReportCardSubject.new(name: subject.name, code: subject.code)
        end
      end
    end
  end

  def check_exams(setting, exams)
    if exams.present?
      if setting.exams.present?
        exams.each do |exam|
          if setting.exams.where(name: exam.name, batch_id: exam.batch_id).blank?
            setting.exams << ReportCardExam.new(name: exam.name, batch_id: exam.batch_id)
          end
        end
      else
        exams.each do |exam|
          setting.exams << ReportCardExam.new(name: exam.name, batch_id: exam.batch_id)
        end
      end
    end
  end

  def get_all_employee_bridges(current_user)
      bridges = []
      grades = Grade.where(section: nil).order('name')
      if current_user.role.rights.where(value: 'enter_all_marks').any?
        grades.each do |grade|
          subgrades = Grade.where('name=? AND section IS NOT NULL', grade.name).order('section')
          subgrades.each do |sub_grade|
            sub_bridges = Bridge.where(grade_id: sub_grade.id)
            bridges = bridges + sub_bridges if sub_bridges.present?
          end
        end
      else
        grades.each do |grade|
          subgrades = Grade.where('name=? AND section IS NOT NULL', grade.name).order('section')
          subgrades.each do |sub_grade|
            sub_bridges = Bridge.where(grade_id: sub_grade.id, employee_id: (Employee.find_by_email(current_user.email) || current_user).id )
            bridges = bridges + sub_bridges if sub_bridges.present?
          end
        end
      end
      bridges
  end

  def get_division_marks(report_card, subject, division, exam)
    if subject.sub_subjects.present?
      marks = 0
      if division.name == "Exam Comments"
        marks = ''
        subject.sub_subjects.each do |sub_subject|
          if marks == ''
            marks = (report_card.marks.find_by(subject_id: sub_subject.id, division_id: division.id, exam_id: exam.id).sessionals.last.try(:comments) || '') if report_card.marks.find_by(subject_id: sub_subject.id, division_id: division.id, exam_id: exam.id).present?
          else
            marks = marks + ","+(report_card.marks.find_by(subject_id: sub_subject.id, division_id: division.id, exam_id: exam.id).sessionals.last.try(:comments) || '') if report_card.marks.find_by(subject_id: sub_subject.id, division_id: division.id, exam_id: exam.id).present?
          end
        end
        unless marks.nil?
          marks.chomp(',') 
          marks[0] = '' if marks[0] == ','
          marks.squeeze(',') 
          marks = marks.split(',').uniq.join(',')
        end
        
      else
        subject.sub_subjects.each do |sub_subject|
          marks = marks + (report_card.marks.find_by(subject_id: sub_subject.id, division_id: division.id, exam_id: exam.id).try(:obtained_marks) || 0) * (sub_subject.weight/100.00)
        end
      end
      marks || 'N/A'
    else
      if division.name == "Exam Comments" && report_card.marks.find_by(subject_id: subject.id, division_id: division.id, exam_id: exam.id).present?
        marks = report_card.marks.find_by(subject_id: subject.id, division_id: division.id, exam_id: exam.id).sessionals.last.try(:comments)
        unless marks.nil?
          marks.chomp(',') 
          marks[0] = '' if marks[0] == ','
          marks.squeeze(',')
          marks = marks.split(',').uniq.join(',')
        end
      else
        report_card.marks.find_by(subject_id: subject.id, division_id: division.id, exam_id: exam.id).try(:obtained_marks)
      end
    end
  end

  def get_quarter_total_avg(report_card, subjects, exam)
    avg = 0
    subjects.each do |subject|
      marks =  get_quarter_total(@report_card, subject, exam)
      unless marks.nil?
        avg = avg + marks 
      end
    end
    avg
  end

  def get_division_marks_avg(report_card, subjects,division, exam)
    if division.name == 'Exam Comments'
      return '- - -'
    else
      avg = 0
      subjects.each do |subject|
        marks =  get_division_marks(report_card, subject,division,exam)
        unless marks.nil?
          avg = avg + marks 
        end
      end
      puts "adlkfjaldksjfladksjflas"
      puts "adlkfjaldksjfladksjflas"
      puts "adlkfjaldksjfladksjflas"
      puts subjects.inspect
      puts "adlkfjaldksjfladksjflas"
      puts "adlkfjaldksjfladksjflas"
      puts "adlkfjaldksjfladksjflas"
      avg/subjects.count
    end
  end

  def get_divisions_total_avg(report_card, subjects, exam, division_ids)
    avg = 0
    subjects.each do |subject|
      avg = avg + get_divisions_total(report_card, subject, exam, division_ids)
    end
    avg
  end

  def get_divisions_total(report_card, subject, exam, division_ids)
    if subject.sub_subjects.present?
      marks = 0
      subject.sub_subjects.each do |sub_subject|
        marks = marks + (report_card.marks.where("subject_id = #{sub_subject.id} AND exam_id = #{exam.id} AND division_id IN(#{division_ids.join(',')})").try(:sum, :obtained_marks) || 0) * (sub_subject.weight/100.00)
      end
      marks
    else
      report_card.marks.where("subject_id = #{subject.id} AND exam_id = #{exam.id} AND division_id IN(#{division_ids.join(',')})").try(:sum, :obtained_marks)
    end
  end

  def get_quarter_total(report_card, subject, exam)

    if subject.present? && subject.sub_subjects.present?
          puts "ajdfljasklfjasdklfjasdklfj"
          puts "ajdfljasklfjasdklfjasdklfj"
          puts "ajdfljasklfjasdklfjasdklfj"
          puts "ajdfljasklfjasdklfjasdklfj"
          puts "ajdfljasklfjasdklfjasdklfj"
          puts "ajdfljasklfjasdklfjasdklfj"
      marks = 0
      subject.sub_subjects.each do |sub_subject|
        marks = marks + (report_card.marks.where("subject_id = #{sub_subject.id} AND exam_id = #{exam.id}").try(:sum, :obtained_marks) || 0) * (sub_subject.weight/100.00)
      end
      marks
    else
      puts
      puts "in else"
      puts subject.inspect
      puts
      if subject.present?
        report_card.marks.where("subject_id = #{subject.id} AND exam_id = #{exam.id}").try(:sum, :obtained_marks)
      else
        0
      end
    end
  end

  def get_quarter_percentage(report_card, setting, subject, exam)
    if subject.sub_subjects.present?
      obtained_marks = 0
      total_marks = 0
      subject.sub_subjects.each do |sub_subject|
        obtained_marks = obtained_marks + (report_card.marks.where("subject_id = #{sub_subject.id} AND exam_id = #{exam.id}").try(:sum, :obtained_marks) || 0.00) * (sub_subject.weight/100.00)
        total_marks = total_marks + (setting.marks_divisions.try(:sum, :total_marks) || 1) * (sub_subject.weight/100.00)
      end
      (obtained_marks/total_marks) * 100.00
    else
      obtained_marks = report_card.marks.where("subject_id = #{subject.id} AND exam_id = #{exam.id}").try(:sum, :obtained_marks) || 0.00
      total_marks = setting.marks_divisions.try(:sum, :total_marks) || 1
      (obtained_marks/total_marks) * 100.00
    end
  end

  def get_term_subject_total(report_card, subject, exam_ids)
    if subject.sub_subjects.present?
      obtained_marks = 0
      subject.sub_subjects.each do |sub_subject|
        obtained_marks = obtained_marks + (report_card.marks.where("subject_id = #{sub_subject.id} AND exam_id IN(#{exam_ids.join(',')})").try(:sum, :obtained_marks) || 0.0) * (sub_subject.weight/100.00)
      end
      obtained_marks
    else
      report_card.marks.where("subject_id = #{subject.id} AND exam_id IN(#{exam_ids.join(',')})").try(:sum, :obtained_marks)
    end
  end

end
