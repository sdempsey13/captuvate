class Campaign < ApplicationRecord
  validates :external_id, presence: true
  validates :source, presence: true  

  belongs_to :workspace
  belongs_to :integration, optional: true

  delegate :organization, to: :workspace

  validates :workspace, presence: true
  validates :name, presence: true
  validates :integration, uniqueness: { scope: :workspace_id, message: "already has a campaign in this workspace" }, allow_nil: true
end
