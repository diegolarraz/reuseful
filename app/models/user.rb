class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items, dependent: :destroy
  has_many :comments, through: :items, dependent: :destroy
  has_many :exchanges, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :first_name, :last_name, :location, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def distance_from_item(item)
    distance_in_miles = self.distance_to(item.user).round(1)
    "#{distance_in_miles} miles away"
  end
end
