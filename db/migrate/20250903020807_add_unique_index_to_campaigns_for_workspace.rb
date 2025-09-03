class AddUniqueIndexToCampaignsForWorkspace < ActiveRecord::Migration[8.0]
  def change
    add_index :campaigns, [:external_id, :workspace_id, :integration_id],
      unique: true,
      name: "index_campaigns_on_external_id_workspace_integration"
  end
end
