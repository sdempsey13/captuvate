class RemoveWorkspacesIdFromIntegrations < ActiveRecord::Migration[8.0]
  def change
    remove_column :integrations, :workspaces_id, :bigint
  end
end
