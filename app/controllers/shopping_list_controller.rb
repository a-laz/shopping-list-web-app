class ShoppingListController < ApplicationController
    get '/shopping_lists' do
        if logged_in?
            @user = current_user
            erb :"shopping_list/index"
        else
            redirect to '/login'
        end
    end

    get '/shopping_lists/new' do
        if logged_in?
            @user = current_user
            erb :"shopping_list/new"
        else
            redirect to '/login'
        end
    end

    post '/shopping_lists' do
        if logged_in?
            @user = current_user
            params[:shopping_list][:name].capitalize
            if ShoppingList.find_by(:name => params[:shopping_list][:name]) && ShoppingList.find_by(:name => params[:shopping][:name]).user == @user
                redirect to '/shopping_lists/new'
            end
            
            @list = ShoppingList.create(:name => params[:shopping_list][:name], :user_id => @user.id)
            
            unless params[:shopping_list][:item_ids] == nil
                params[:shopping_list][:item_ids].each do |item_id|
                    @list.items << Item.find(item_id)
                end
            end

            unless params[:item][:name].empty?
                @list.items << Item.create(:name => params[:item][:name], :price => params[:item][:price], :user => @user)
            end
            redirect to "/shopping_lists/#{@list.id}"
        else
            redirect to '/login'
        end
    end

    get '/shopping_lists/:id' do
        if logged_in?
            @list = ShoppingList.find(params[:id])
            erb :"shopping_list/show"
        else
            redirect to '/login'
        end
    end

    get '/shopping_lists/:id/edit' do
        if logged_in?
            @list = ShoppingList.find(params[:id])
            if @list && @list.user == current_user
               erb :"shopping_list/edit"
            else
                redirect to '/shopping_lists'
            end
        else
            redirect to '/login'
        end
    end

    patch '/shopping_lists/:id' do
        if logged_in?
            @list = ShoppingList.find(params[:id])
            if @list && @list.user == current_user
                @list.update(params[:shopping_list])
                params[:shopping_list][:item_ids].each do |item_id|
                    unless @list.items.find(Item.find(item_id))
                        @list.items << Item.find(item_id)
                    end
                end
                unless params[:item][:name].empty?
                    @list.items << Item.create(params[:item])
                end
                redirect to("/shopping_lists/#{@list.id}")
            else
                redirect to '/shopping_lists'
            end
        else
            redirect to '/login'
        end
    end

    delete '/shopping_lists/:id' do
        if logged_in?
            @list = ShoppingList.find_by(params[:id])
            if @list && @list.user == current_user
                @list.delete
                redirect to '/shopping_lists'
            else
                redirect to '/shopping_lists'
            end
        else
            redirect to '/login'
        end
    end

end