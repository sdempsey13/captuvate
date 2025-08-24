class Integration < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :integration_credentials

  has_many :campaigns
end
