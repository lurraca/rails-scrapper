class AddNegkeywordsToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :neg_keywords, :string
  end
end
