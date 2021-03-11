class RemoveAboutmeFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :about_me, :text
  end
end
