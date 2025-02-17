class SnapShot < ApplicationRecord
  belongs_to :domain

  has_one_attached :screen_shot do |attachable|
    attachable.variant :thumb, crop: [0, 0, 1000, 1000], preprocessed: true
  end
end
