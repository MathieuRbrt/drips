class Post < ActiveRecord::Base
	has_attached_file :picture,
						:convert_options => { :all => "-quality 75" },
						:styles => { :small => "360x" },
						:url => "/assets/posts/:id/:style/:basename.:extension",
						:path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

	validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }, size: { less_than: 5.megabytes }
	validates :picture, presence: true
	validates :location, presence: true
	validates :city, presence: true
	validates :user_id, presence: true
	geocoded_by :full_address

	belongs_to :user
	belongs_to :artist

	after_validation :geocode

	def full_address
    	location + ", " + city
   	end

end
