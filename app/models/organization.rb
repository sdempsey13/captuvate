class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships

  has_many :workspaces, dependent: :destroy
  has_many :integrations, through: :workspaces
  has_many :api_credentials, through: :integrations
  has_many :webhook_credentials, through: :integrations

  has_many :campaigns
end
