class Page < ApplicationRecord
  belongs_to :user
  belongs_to :page_group

  validates :url, presence: true
end
