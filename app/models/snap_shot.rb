class SnapShot < ApplicationRecord
  belongs_to :domain

  has_one_attached :screen_shot
end
