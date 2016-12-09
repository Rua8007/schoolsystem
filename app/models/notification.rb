class Notification < ActiveRecord::Base
	
	belongs_to :user

	def image
		if !self.user.try(:image).present?
			"profile_placeholder.png"
		else
			self.user.image
		end
	end
end
