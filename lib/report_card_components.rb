module ReportCardComponents

  def termwork
    self.marks_divisions.where(is_divisible: true).length
  end

  def termwork_total
    1
  end

  def exams
    self.marks_divisions.where(is_divisible: false).length
  end

  def exams_total
    1
  end

  def quarter_total
    1
  end

  def quarter_percentage
    1
  end

  def evaluation
    1
  end

end