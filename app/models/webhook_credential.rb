class WebhookCredential < ApplicationRecord
  belongs_to :integration

  validates :encrypted_secret_key, presence: :true
  validates :integration, presence: true
  validates :integration_id, uniqueness: { scope: :organization_id, message: 'Your webhook has already been set' }

  encrypts :encrypted_secret_key   
end
