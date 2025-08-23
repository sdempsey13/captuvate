class AddOrganizationToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_reference :campaigns, :organization, null: true, foreign_key: true
  end
end
