class Parent < ActiveRecord::Base
	has_many :students

	has_many :emergencies

	accepts_nested_attributes_for :emergencies

	EMAIL_ATTRIBUTES = {
			name: '{{parent.full_name}}',
			email: '{{parent.email}}',
			mobile: '{{parent.mobile}}',
			mother_mobile: '{{parent.mothermobile}}',
			mother_name: '{{parent.mothername}}',
	}
	
end
