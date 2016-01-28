class Parent < ActiveRecord::Base
	has_many :students

	has_many :emergencies

	accepts_nested_attributes_for :emergencies

	EMAIL_ATTRIBUTES = {
			name: '{{parent.name}}',
			email: '{{parent.email}}',
			mobile: '{{parent.mobile}}',
			mother_mobile: '{{parent.mothermobile}}',
			mother_name: '{{parent.mothername}}',
			login_info: '{{parent.login_info}}'
	}

	def login_info
		std = Student.find_by_parent_id(self.id)
		if std.present?
			"Email: #{std.email} Password: #{User::DEFAULT_PASSWORD}"
		else
			'Invalid Parent...'
		end
	end
	
end
