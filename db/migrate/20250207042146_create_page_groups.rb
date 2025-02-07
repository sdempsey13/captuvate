class CreatePageGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :page_groups do |t|

      t.timestamps
    end
  end
end
