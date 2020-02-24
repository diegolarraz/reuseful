class Item < ApplicationRecord
  belongs_to :user
  has_many :exchanges, dependent: :destroy
  has_many :comments, dependent: :destroy

  CATEGORIES = %w(clothing furniture appliances electronics DIY garden travel other)
  validates :name, :description, :category, presence: true
  validates :category, inclusion: {in: CATEGORIES}
  validates :description, length: {minimum: 10}
end
