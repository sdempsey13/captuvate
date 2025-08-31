class CreateWebhookCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :webhook_credentials do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :integration, null: false, foreign_key: true
      t.string :encrypted_secret_key

      t.timestamps
    end

    add_index :webhook_credentials, [:organization_id, :integration_id], unique: true
  end
end
