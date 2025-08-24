class IntegrationCredential < ApplicationRecord
  belongs_to :organization
  belongs_to :integration

  validates :encrypted_api_key, presence: :true
  validates :integration_id, uniqueness: { scope: :organization_id, message: "you already have an API Key set for this integration" }

  encrypts :encrypted_api_key

  before_save :set_masked_api_key, if: -> { encrypted_api_key_changed? && encrypted_api_key.present? }

  after_create :back_populate_new_integration

  private

  def set_masked_api_key
    self.masked_api_key = "*****#{self.encrypted_api_key.last(5)}"
  end

  def back_populate_new_integration
    BackPopulateOrchestratorJob.perform_later(self)
  end
end
