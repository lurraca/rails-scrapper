class AddMinKeywordsToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :min_keywords, :int
  end
end
