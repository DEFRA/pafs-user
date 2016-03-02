class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :reference_number, null: false
      t.integer :version, null: false
      t.string :name

      t.timestamps null: false
    end

    add_index :projects, [:reference_number, :version], unique: true
  end
end
