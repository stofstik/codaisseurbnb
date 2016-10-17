class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_rooms, through: :bookings, source: :room

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.active_users
    where('last_sign_in_at >= ?', Time.now - 3.months)
  end

  def has_profile?
    profile.present?
  end

  def full_name
    profile.full_name
  end
end
