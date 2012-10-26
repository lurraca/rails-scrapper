class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url
      t.boolean :scapped
      t.boolean :valid
      t.string :title
      t.references :batch

      t.timestamps
    end
    add_index :sites, :batch_id
  end
end
