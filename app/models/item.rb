class Item < ApplicationRecord
  belongs_to :user
  has_many :exchanges, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :pictures

  CATEGORIES = %w(Clothing Furniture Appliances Electronics DIY Garden Travel Other)
  validates :name, :description, :category, presence: true
  validates :category, inclusion: {in: CATEGORIES}
  validates :description, length: {minimum: 10}
end
