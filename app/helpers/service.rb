class Service < ActiveRecord::Base
	belongs_to :alert
	# I want to pass the user's choosen line, and   choosen line = Service.name
	scope :track_it, lambda{|trainline| where(["name LIKE ?", "%#{user_trainline}%"])}
end
