class LessonplanDetail < ActiveRecord::Base

	belongs_to :lessonplan
	belongs_to :subject

  mount_uploader :attachment, ImageUploader
end
