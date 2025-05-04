class SnapShot < ApplicationRecord
  enum :format, { desktop: 0, mobile: 1 }
  
  belongs_to :domain

  has_many :comments, dependent: :destroy

  has_one_attached :screen_shot do |attachable|
    attachable.variant :thumb, crop: [0, 0, 1000, 1000], preprocessed: true
  end
end
