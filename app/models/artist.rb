class Artist < ActiveRecord::Base
	has_many :posts
	has_many :suggestions
end
