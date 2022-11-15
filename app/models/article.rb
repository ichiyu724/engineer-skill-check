class Article < ApplicationRecord
  belongs_to :employee

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true

  scope :active, lambda {
    where(deleted_at: nil)
  }
end
