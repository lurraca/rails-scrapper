class CreateMatchedLinks < ActiveRecord::Migration
  def change
    create_table :matched_links do |t|
      t.references :site
      t.string :keyword
      t.text :link_text
      t.text :link_url

      t.timestamps
    end
    add_index :matched_links, :site_id
  end
end
