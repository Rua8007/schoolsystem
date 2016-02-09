class Week < ActiveRecord::Base
	has_many :grade_subjects
	belongs_to :year_plan

	def start_end_date
		"#{start_date.strftime("%d/%m")} - #{end_date.strftime("%d/%m")}"
	end

	def label
		"Week# #{year_week_id} - (#{start_date.strftime('%d-%m-%Y')} / #{end_date.strftime('%d-%m-%Y')})"
	end
end
