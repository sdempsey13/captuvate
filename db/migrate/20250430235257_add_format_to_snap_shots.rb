class AddFormatToSnapShots < ActiveRecord::Migration[8.0]
  def change
    add_column :snap_shots, :format, :integer, null: false, default: 0
  end
end
