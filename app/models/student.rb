class Student < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	belongs_to :parent
end
