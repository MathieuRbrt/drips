class Suggestion < ActiveRecord::Base
	belongs_to :user
	belongs_to :artist
	belongs_to :post
end
