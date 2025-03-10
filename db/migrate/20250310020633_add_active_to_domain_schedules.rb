class AddActiveToDomainSchedules < ActiveRecord::Migration[8.0]
  def change
    add_column :domain_schedules, :active, :boolean, default: true, null: false
    add_index :domain_schedules, :active
  end
end
