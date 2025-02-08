class Domain < ApplicationRecord
  belongs_to :user

  has_many :snap_shots, dependent: :destroy

  validates :url, presence: true
end
