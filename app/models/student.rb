class Student < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	belongs_to :parent
	belongs_to :grade
	has_many :documents
	has_many :emergencies

	has_one :bus_allotment

	has_one :emergency
	has_many :fees

	has_many :student_attendances

	accepts_nested_attributes_for :emergencies

	has_many :marksheets

	has_many :invoices

	has_many :performances
	has_many :sessionals
	has_one :report_card

	has_many :dues, dependent: :destroy
	accepts_nested_attributes_for :dues, allow_destroy: :true

  validates_uniqueness_of :rollnumber
  validates_presence_of :rollnumber

	EMAIL_ATTRIBUTES = {
			name: '{{student.fullname}}',
			rollnumber: '{{student.rollnumber}}',
      login_info: '{{student.login_info}}'
  }

	LIST_HEADER = [ {label: 'ID',          method: 'rollnumber'},
									{label: 'full_name',   method: 'fullname'},
									{label: 'father_name', method: 'father_name'},
									{label: 'email',       method: 'email'},
									{label: 'grade',       method: 'grade_name'},
									{label: 'mobile',       method: 'mobile'}
	]
	default_scope {where(:is_deleted => false)}

	def self.deleted
  	self.unscoped.where(is_deleted: true)
	end

	def login_info
		if self.email.present?
      "Email: #{self.email} Password: #{User::DEFAULT_PASSWORD}"
		else
			'Not Found...'
		end
  end

  def father_name
    parent.try(:name)
  end

  def grade_name
    grade.try(:full_name)
  end


	def testi
		puts "+=+=" *100
		puts "+=+=" *100
		puts "+=+=" *100
	end


	def self.import(file)
		# puts "--------in import of model--------"
		# begin
		# 	puts "--------in begin--------"

		#   # CSV.foreach(file.path, headers: true) do |row|
		#   #   emp = User.new
		#   #   emp.attributes = row.to_hash.slice(*row.to_hash.keys)
		#   #   emp.save
		#   #   # blood = father number
		#   #   p = Parent.create
		#   #   emp.parent_id = p.id
		#   #   p.mobile = emp.blood
		#   #   p.mothermobile = emp.rh
		#   #   emp.blood = ''
		#   #   emp.rh = ''
		#   #   emp.email = emp.email.downcase+'_'+emp.rollnumber+'@alomam.edu.sa'

	 #   # #    email="std_"+emp.rollnumber.to_s+"@alomam.edu.sa"
	 #   # #    emp.email = email
		#   # #   emp.save!

	 #   # #    puts "=================="
		# 		# # puts 'Creating Student user'
		# 		# # puts "=================="


	 #   #    u = User.new
	 #   #    u.email = emp.email
	 #   #    u.password = '123'
	 #   #    u.password_confirmation = '123'
	 #   #    u.role_id = Role.find_by_name('Parent').id
		#   #   u.is_active = true

	 #   #    u.save
	 #   #    emp.save
	 #   #    puts "+++++++++++++++++++"
  #   #   # ================== Student script end==========================
  #   #   # ===========================employee script=======================
 	# 		# # emp = Employee.new
		#   # # emp.attributes = row.to_hash.slice(*row.to_hash.keys)
		#   # # emp.category_id = Category.find_by_name('Academic').id
		#   # # emp.department_id = Department.first.id
		#   # # user = Role.find_by_name('Teacher').users.new
		#   # # user.email = emp.email
		#   # # user.password = '123'
		#   # # user.password_confirmation = '123'
		#   # # user.save
		#   # # emp.save

  #   #   # ======================employee script end======================
		#   # end
		# rescue => e
		# 	puts "=================="
		# 	puts e
		# 	puts "=================="
	 #        # Rails.logger.error { "Encountered an error" }
  #     		"notok"
  #     	end
	end

  def copy_report_cards(new_grade)
    old_grade = self.grade
    main_grade = old_grade.parent
    batch = Batch.last
    @report_card = ReportCard.find_by(student_id: @student.id, grade_id: @class.id, batch_id: @batch.id)
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: @batch.id)
    @exams.each do |exam|
    	@report_card = ReportCard.find_by(student_id: @student.id, grade_id: @class.id, batch_id: @batch.id, exam_id: exam.id)
    	@report_card.grade_id = new_grade.id
    end
    # @settings = ReportCardSetting.where(grade_id: main_grade.id, batch_id: batch.id)
    # new_grade.students.first.marksheets.where(grade_id: new_grade.id ).each do |marksheets|
    # 	self.marksheets.find_by(grade_id: old_grade.id, subject_id:)
    # end
    
  end

end













