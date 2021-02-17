class Item < ActiveRecord::Base
    has_and_belongs_to_many :shopping_lists
    belongs_to :user
end