class CreateDomainSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :domain_schedules do |t|
      t.references :domain, null: false, foreign_key: true
      t.integer :frequency, null: false
      t.timestamps
    end

    add_index :domain_schedules, :frequency
  end
end
