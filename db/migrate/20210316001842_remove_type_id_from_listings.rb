class RemoveTypeIdFromListings < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :type_id, :string
  end
end
