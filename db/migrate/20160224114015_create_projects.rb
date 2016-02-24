class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :reference_number, null: false
      t.string :name

      t.timestamps null: false
    end

    add_index :projects, :reference_number, unique: true
  end
end
