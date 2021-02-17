class CreateShoppingListsItemsTable < ActiveRecord::Migration
  def change
    create_table :items_shopping_lists, id: false do |t|
      t.belongs_to :shopping_list
      t.belongs_to :item
    end
  end
end
