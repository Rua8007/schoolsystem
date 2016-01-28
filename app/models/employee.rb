class Employee < ActiveRecord::Base

	has_many :employee_attendances
	has_many :leaves

	belongs_to :category
	belongs_to :position
	belongs_to :department

	has_many :bridges
	has_many :subjects ,through: :bridges

	has_many :transports
	has_many :routes ,through: :transports

	has_many :marksheets

	has_many :transports

	has_many :purchases

	EMAIL_ATTRIBUTES = {
			name: '{{employee.full_name}}',
			emp_number: '{{employee.employee_number}}',
			login_info: '{{student.login_info}}'
	}

  def login_info
    if self.email.present?
      "Email: #{self.email} Password: #{User::DEFAULT_PASSWORD}"
    else
      'Not Found...'
    end
  end


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
		    emp.category_id = Category.find_by_name('Academic').id
		    emp.department_id = Department.first.id
		    u = User.new
		    u.email = emp.email
		    u.password = '786'
		    u.password_confirmation = '786'
		    u.role_id = Role.find_by_name('Teacher').id
		    u.is_active = true
		    u.save
		    if Employee.any?
		    	emp.employee_number = 'emp_'+ (Employee.last.id+1).to_s
		    else
		    	emp.employee_number = 'emp_1'
		    end

		    emp.save!
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
