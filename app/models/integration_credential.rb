class IntegrationCredential < ApplicationRecord
  belongs_to :organization
  belongs_to :integration

  validates :encrypted_api_key, presence: :true
  validates :integration_id, uniqueness: { scope: :organization_id, message: "you already have an API Key set for this integration" }

  encrypts :encrypted_api_key
end
