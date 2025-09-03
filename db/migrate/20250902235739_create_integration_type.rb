class CreateIntegrationType < ActiveRecord::Migration[8.0]
  def change
    create_table :integration_types do |t|
      t.string  :display_name, null: false
      t.string  :key, null: false, index: { unique: true }
      t.integer  :category
      t.boolean  :enabled, null: false, default: true

      t.timestamps
    end
  end
end
