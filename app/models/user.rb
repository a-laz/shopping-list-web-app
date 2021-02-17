class User < ActiveRecord::Base
    has_secure_password
    has_many :shopping_lists
end