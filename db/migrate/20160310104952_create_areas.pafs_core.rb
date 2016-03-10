# This migration comes from pafs_core (originally 20160309111322)
class CreateAreas < ActiveRecord::Migration
  def change
    create_table :pafs_core_areas do |t|
      t.string :name, index: true
      t.integer :parent_id
      t.string :area_type

      t.timestamps null: false
    end
  end
end
