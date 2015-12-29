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

	validates_uniqueness_of :rollnumber
	validates_presence_of :rollnumber


	def testi
		puts "+=+=" *100
		puts "+=+=" *100
		puts "+=+=" *100
	end


	def self.import(file)
		puts "--------in import of model--------"
		begin
		puts "--------in begin--------"

		  CSV.foreach(file.path, headers: true) do |row|
		  #   emp = new
		  #   emp.attributes = row.to_hash.slice(*row.to_hash.keys)
		  #   puts "========file opened=========="
		  # 	puts emp
		  # 	puts "========file opened=========="
		  #   if Student.all.any?
		  #     emp.rollnumber = Student.last.rollnumber.to_i + 1
		  #   else
		  #     emp.rollnumber = '15001'
		  #   end

		  #   emerg = emp.emergencies.new
	   #    emerg.name = emp.hearing
	   #    emp.hearing = ''
	   #    emerg.mobile = emp.rh
	   #    emp.rh = ''
	   #    emerg.phone = emp.alergy
	   #    emp.alergy = ''
	   #    emerg.email = emp.email
	   #    emp.email = ''

		  #   emp.save!


	   #    email="std_"+emp.rollnumber.to_s+"@alomam.edu.sa"
	   #    emp.email = email
		  #   emp.save!

	   #    puts "=================="
				# puts 'Creating Student user'
				# puts "=================="


	   #    u = User.new
	   #    u.email = email
	   #    u.password = '123'
	   #    u.password_confirmation = '123'
	   #    u.role_id = Role.find_by_name('Student').id
		  #   u.is_active = true

	   #    u.save
	   #    emp.save

      # ================== Student script end==========================
      # ===========================employee script=======================
 			emp = Employee.new
		  emp.attributes = row.to_hash.slice(*row.to_hash.keys)
		  emp.category_id = Category.find_by_name('Academic').id
		  emp.department_id = Department.first.id
		  user = Role.find_by_name('Teacher').users.new
		  user.email = emp.email
		  user.password = '123'
		  user.password_confirmation = '123'
		  user.save
		  emp.save



      # ======================employee script end======================
		  end
		rescue => e
			puts "=================="
			puts e
			puts "=================="
	        # Rails.logger.error { "Encountered an error" }
      		"notok"
      	end
	end

end
