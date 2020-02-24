class Exchange < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :date, :location, presence: true
end
