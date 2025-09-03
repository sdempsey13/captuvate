class ApiCredential < ApplicationRecord
  belongs_to :integration

  validates :encrypted_api_key, presence: :true
  validates :integration, presence: true
  validates :integration_id, uniqueness: true

  encrypts :encrypted_api_key

  before_save :set_masked_api_key, if: -> { encrypted_api_key_changed? && encrypted_api_key.present? }

  after_create :sync_new_integration

  private

  def set_masked_api_key
    self.masked_api_key = "*****#{self.encrypted_api_key.last(5)}"
  end

  def sync_new_integration
    PlatformSyncOrchestratorJob.perform_later(self)
  end
end
