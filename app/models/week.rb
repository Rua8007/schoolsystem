class Week < ActiveRecord::Base
	has_many :grade_subjects
	belongs_to :year_plan

	validates :start_date, :end_date, :expiry_date, presence: true
	validates :year_week_id, uniqueness: true

	validate :check_expiry_date

	def check_expiry_date
		if expiry_date < start_date
			errors.add(:base, 'Expiry Date should be greater than or equal to start date.')
		end
	end

	def start_end_date
		"#{start_date.strftime("%d/%m")} - #{end_date.strftime("%d/%m")}"
	end

	def label
		"Week# #{year_week_id} - (#{start_date.strftime('%d-%m-%Y')} / #{end_date.strftime('%d-%m-%Y')})"
	end
end
