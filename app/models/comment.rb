class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :snap_shot

  validates :content, presence: true, length: { maximum: 1000 }
end
