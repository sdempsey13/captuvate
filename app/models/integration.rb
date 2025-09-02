class Integration < ApplicationRecord
  validates :display_name, presence: true, uniqueness: true

  has_many :api_credentials
  has_many :webhook_credentials

  has_many :campaigns
end
