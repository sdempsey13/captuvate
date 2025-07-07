class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns do |t|
      t.integer :external_id, null: false, index: true
      t.string :source, null: false
      t.string :name
      t.string :status
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
