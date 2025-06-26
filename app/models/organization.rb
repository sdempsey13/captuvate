class Organization < ApplicationRecord
  validates :name, presence: true

  has_many :users
  has_many :integration_credentials
  has_many :integrations, through: :integration_credentials
end
