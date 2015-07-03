class Document < ActiveRecord::Base

	belongs_to :student
	mount_uploader :attachment, ImageUploader
end
