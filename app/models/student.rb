class Student < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	
	belongs_to :parent
	belongs_to :grade
	has_many :documents
	has_many :emergencies

	has_one :bus_allotment

	has_many	:emergencies
	has_many :fees

	has_many :student_attendances
	has_one :bus_allotment
	
	accepts_nested_attributes_for :emergencies

	has_many :marksheets

	has_many :invoices
	

	
end
