class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:stripe_connect]
  has_many :projects, dependent: :destroy #if a user is deleted, the project they created is as well

  def can_receive_payments?
    uid? &&  provider? && access_code? && publishable_key?
  end

end