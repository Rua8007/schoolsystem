class Notification < ActiveRecord::Base
	
	belongs_to :user

	def image
		if self.user.role == 'Parent'
			Student.find_by_rollnumber(self.user.email.split('@').first.split('_').last).try(:image)
		elsif self.user.role == 'Teacher'
			"profile_placeholder.png"
		else
			"profile_placeholder.png"
		end
	end
end
