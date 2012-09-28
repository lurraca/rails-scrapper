class AddBusinessToSite < ActiveRecord::Migration
  def change
    add_column :sites, :business, :boolean
  end
end
