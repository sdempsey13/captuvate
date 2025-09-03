class AddReferenceToIntegrations < ActiveRecord::Migration[8.0]
  def change
    add_reference :integrations, :integration_type, null: false, foreign_key: true
  end
end
