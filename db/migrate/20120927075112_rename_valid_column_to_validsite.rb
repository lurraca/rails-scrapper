class RenameValidColumnToValidsite < ActiveRecord::Migration
  def up
  	rename_column(:sites, :valid, :valid_site)
  end

  def down
  	rename_column(:sites, :valid_site, :valid)
  end
end
