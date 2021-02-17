class CreateShoppingListsTable < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.string :name
      t.references :user
    end
  end
end
