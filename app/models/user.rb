class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_merit

  make_flagger :flag_once => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :profile_name, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_\-]+\z/, message: 'Must be formatted correctly.'}
         validates :email, presence: true
         has_many :posts
         has_many :suggestions

         def full_name
         	first_name + " " + last_name
         end

         def soft_delete
          update_attribute(:deleted_at, Time.current)
        end

         def user_params
      params.require(:user).permit(:avatar)
    end

end
