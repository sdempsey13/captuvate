class IntegrationType < ApplicationRecord
  has_many :integrations, dependent: :destroy

  validates :name, presence: true
  validates :key, presence: true, uniqueness: true
  
  enum :category, { ab_platform: 0 }
end