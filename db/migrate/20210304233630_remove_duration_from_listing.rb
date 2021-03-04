class RemoveDurationFromListing < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :duration, :time
  end
end
