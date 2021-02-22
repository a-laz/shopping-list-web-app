# shopping-list-web-app

This web app allows Users to create and store items within shopping lists.

Domain

    * User
        - has_many :shopping_lists

    * Shopping List
        - belongs_to :user
        - has_and_belongs_to_many :items

    * Items
        - belongs_to :user
        - has_and_belongs_to_many :shopping_lists


Install

    * In the root directory run `bundle install`

    * Start server with `rackup config.ru`




MIT License