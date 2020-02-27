class Item < ApplicationRecord
  belongs_to :user
  has_many :exchanges, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :pictures

  # , :maximum => 3

  CATEGORIES = %w(Clothing Furniture Appliances Electronics DIY Garden Travel Other)
  validates :name, :description, :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :description, length: { minimum: 10 }

  def time_since_posted
    time_diff = Time.now - created_at
    if (time_diff / 1.minute).round == 1
      return "#{(time_diff / 1.minute).round} minute ago"
    elsif (time_diff / 1.minute).round < 60
      return "#{(time_diff / 1.minute).round} minutes ago"
    elsif (time_diff / 1.hour).round == 1
      return "#{(time_diff / 1.hour).round} hour ago"
    elsif (time_diff / 1.hour).round < 24
      return "#{(time_diff / 1.hour).round} hours ago"
    elsif (time_diff / 1.day).round == 1
      return "#{(time_diff / 1.day).round} day ago"
    else
      return "#{(time_diff / 1.day).round} days ago"
    end
  end

  include PgSearch::Model
   pg_search_scope :search_by_category_and_name,
    against: [ :category, :name ],
    using: {
      tsearch: { prefix: true }
    }
end
