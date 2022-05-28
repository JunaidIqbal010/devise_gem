class User < ApplicationRecord
  attr_accessor :signin
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  validates :username, :uniqueness => {:case_sensitive => false}

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if conditions[:signin].present?
      where("lower(username) = :value OR lower(email) = :value", { :value => conditions[:signin]&.downcase }).first
    else
      debugger
      where(conditions).first
    end
  end
end
