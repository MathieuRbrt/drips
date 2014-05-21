class Post < ActiveRecord::Base
	make_flaggable
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

	geocoded_by :full_address do |obj,results|
	  if geo = results.first
	    obj.country = geo.country
	    obj.latitude = geo.latitude
	    obj.longitude = geo.longitude
	  end
	end


	belongs_to :user
	belongs_to :artist

	after_validation :geocode, :if => Proc.new { latitude.blank? }

	scope :approved, -> { where(approved: true) }
	scope :not_approved, -> { where(approved: false) }

	def full_address
    	location + ", " + city
   	end

   	private

end
