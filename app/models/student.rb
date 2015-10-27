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

	validates_uniqueness_of :rollnumber
	validates_presence_of :rollnumber


	def self.import(file)
		puts "--------in import of model--------"
		begin
		puts "--------in begin--------"

		  CSV.foreach(file.path, headers: true) do |row|
		    emp = new
		    emp.attributes = row.to_hash.slice(*row.to_hash.keys)
		    puts "========file opened=========="
		  	puts emp
		  	puts "========file opened=========="
		    if Student.all.any?
		      emp.rollnumber = Student.last.rollnumber.to_i + 1
		    else
		      emp.rollnumber = '15001'
		    end

		    emerg = emp.emergencies.new
	      emerg.name = emp.hearing
	      emp.hearing = ''
	      emerg.mobile = emp.rh
	      emp.rh = ''
	      emerg.phone = emp.alergy
	      emp.alergy = ''
	      emerg.email = emp.email
	      emp.email = ''

		    emp.save!


	      email="std_"+emp.rollnumber.to_s+"@alomam.edu.sa"
	      emp.email = email
		    emp.save!

		    puts "=================="
				puts 'Creating Parent'
				puts "=================="
		    prt = Parent.new
		    prt.email = emp.nurology+"_"+emp.rollnumber.to_s+"@alomam.edu.sa"
		    prt.save!
		    emp.parent_id = prt.id

		    		    puts "=================="
				puts 'Creating Parent user'
				puts "=================="

		    u = User.new
	      u.email = prt.email
	      u.password = '123'
	      u.password_confirmation = '123'
	      u.role_id = Role.find_by_name('Parent').id
		    u.is_active = true

	      u.save

	      puts "=================="
				puts 'Creating Student user'
				puts "=================="


	      u = User.new
	      u.email = email
	      u.password = '123'
	      u.password_confirmation = '123'
	      u.role_id = Role.find_by_name('Student').id
		    u.is_active = true

	      u.save

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
