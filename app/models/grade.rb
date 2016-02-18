class Grade < ActiveRecord::Base
	belongs_to :batch
	has_many :bridges
	has_many :subjects ,through: :bridges
	has_many :students
	has_many :marks
	has_many :marksheets
	has_many :items
	has_many :packages
	has_many :portions
	has_many :lessonplans
	has_many :curriculums
	has_many :feebreakdowns
	has_many :purchases
	has_many :associations

	has_many :exams

	belongs_to :grade_group
	# has_many :subjects ,through: :associations


	has_many :grade_subjects
	has_many :examcalenders

	after_save :save_grade_group

	validates :name, presence: true
  validate :unique_name
	validates :max_no_of_students, presence: true, if: 'section.nil?'
	validate :unique_full_name?

	LIST_HEADER = [ {label: 'grade',          method: 'name'},
									{label: 'class',          method: 'section'},
									{label: 'batch',          method: 'batch_name'},
									{label: 'section',        method: 'section_type'},
									{label: 'no_of_students', method: 'no_of_students'}
	]


  def batch_name
    batch.try(:name)
  end

  def section_type
    case section
      when 'A'
        'Boys'
      when 'B'
        'Girls'
    end
  end

  def no_of_students
    students.try(:count)
  end

	def full_name
	   "#{name} (#{section})"
	end

	def unique_full_name?
    full_name = self.full_name
    @grades = Grade.where.not section: nil
    @grades.each do |grade|
      if full_name == grade.full_name and self.id != grade.id
        self.errors.add(:section, 'This class is already present.')
        return false
      end
    end
    true
	end

	def unique_name
		if self.section.nil?
			return Grade.where(name: self.name, section: nil).any?
		else
			true
		end
	end

	def parent
		Grade.where('name = ? AND section IS NULL', self.name).try(:first)
	end

	def save_grade_group
		if self.grade_group.present?
			self.grade_group.name = self.name
			self.grade_group.save
		else
			self.grade_group = GradeGroup.new(name: self.name)
			self.grade_group.save
		end
	end
end
