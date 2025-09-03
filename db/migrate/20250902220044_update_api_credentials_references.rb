class UpdateApiCredentialsReferences < ActiveRecord::Migration[8.0]
  def change
    add_reference :integrations, :workspace, null: false, foreign_key: true
  end
end
