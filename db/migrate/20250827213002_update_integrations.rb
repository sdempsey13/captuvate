class UpdateIntegrations < ActiveRecord::Migration[8.0]
  def change
    rename_column :integrations, :name, :display_name

    add_column :integrations, :platform, :string
  end
end
