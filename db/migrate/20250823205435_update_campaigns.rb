class UpdateCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_reference :campaigns, :organization, null: true, foreign_key: true
    add_reference :campaigns, :integration, null: true, foreign_key: true

    add_column :campaigns, :campaigns_metadata, :jsonb, default: {}
    add_column :campaigns, :campaign_metadata, :jsonb, default: {}

    remove_column :campaigns, :source, :string
    remove_column :campaigns, :ended_at, :datetime

    rename_column :campaigns, :started_at, :campaign_created_at

    add_index :campaigns, [:external_id, :integration_id, :organization_id], unique: true, name: 'index_campaigns_on_external_platform_org'
  end
end
