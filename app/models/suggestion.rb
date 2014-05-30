class Suggestion < ActiveRecord::Base
	belongs_to :user
	belongs_to :artist
	belongs_to :post

	validates :artist_id, presence: true
end
