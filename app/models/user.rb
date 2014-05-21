class User < ActiveRecord::Base
  has_merit

  make_flagger
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :profile_name, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_\-]+\z/, message: 'Must be formatted correctly.'}
         validates :email, presence: true
         has_many :posts

         def full_name
         	first_name + " " + last_name
         end

         def soft_delete
          update_attribute(:deleted_at, Time.current)
        end

end
