class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :organization_memberships
  has_many :users, through: :organization_memberships
  
  has_many :integration_credentials
  has_many :integrations, through: :integration_credentials

  has_many :campaigns
end
