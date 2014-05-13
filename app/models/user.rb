class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :profile_name, presence: true, uniqueness: true, format: {with: /a-zA-Z0-9_-/, message: 'Must be formatted correctly.'}
         validates :email, presence: true
         has_many :posts

         def full_name
         	first_name + " " + last_name
         end


end
