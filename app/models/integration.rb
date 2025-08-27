class Integration < ApplicationRecord
  validates :display_name, presence: true, uniqueness: true

  has_many :integration_credentials

  has_many :campaigns
end
