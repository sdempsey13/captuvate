class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships

  has_many :workspaces, dependent: :destroy
  
  has_many :integration_credentials
  has_many :integrations, through: :integration_credentials

  has_many :webhook_credentials

  has_many :campaigns
end
