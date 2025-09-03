class UpdateIntegrations < ActiveRecord::Migration[8.0]
  def change
    remove_column :integrations, :name, :string

    add_reference :integrations, :workspace, null: false, foreign_key: true

    add_column :integrations, :status, :integer
  end
end
