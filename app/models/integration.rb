class Integration < ApplicationRecord
  belongs_to :workspace
  validates :workspace, presence: true

  belongs_to :integration_type
  validates :integration_type, presence: true

  validates :status, presence: true, inclusion: { in: %w[active disconnected error] }

  has_many :api_credentials, dependent: :destroy
  has_many :webhook_credentials, dependent: :destroy

  has_many :campaigns

  enum :status, { active: 0 }
end






