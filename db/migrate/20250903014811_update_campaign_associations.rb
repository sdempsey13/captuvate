class UpdateCampaignAssociations < ActiveRecord::Migration[8.0]
  def up
    # Remove the column and index; skip FK
    remove_reference :campaigns, :organization, index: true

    # Add workspace reference
    add_reference :campaigns, :workspace, null: false, foreign_key: true, index: true

    # Make integration optional
    change_column_null :campaigns, :integration_id, true
  end

  def down
    add_reference :campaigns, :organization, null: false, index: true
    remove_reference :campaigns, :workspace, index: true, foreign_key: true
    change_column_null :campaigns, :integration_id, false
  end
end