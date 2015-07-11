class Student < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	belongs_to :parent
	has_many :documents
	has_many	:emergencies
	accepts_nested_attributes_for :emergencies

	
end
