class LessonplanDetail < ActiveRecord::Base
	belongs_to :lessonplan
	belongs_to :subject
end
