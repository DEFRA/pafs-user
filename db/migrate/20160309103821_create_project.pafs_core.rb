# This migration comes from pafs_core (originally 20160307131830)
class CreateProject < ActiveRecord::Migration
  def change
    create_table :pafs_core_projects do |t|
      t.string :reference_number, null: false
      t.integer :version, null: false
      t.string :name

      t.timestamps null: false
    end

    add_index :pafs_core_projects, [:reference_number, :version], unique: true
  end
end
