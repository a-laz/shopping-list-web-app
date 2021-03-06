require 'rack-flash'

class ItemController < ApplicationController
    use Rack::Flash

    get '/items' do
        if logged_in?
            erb :"items/index"
        else
            redirect to '/login'
        end
    end

    get '/items/new' do
        if logged_in?
            erb :"items/new"
        else
            redirect to '/login'
        end
    end

    post '/items' do
        if logged_in?
            if params[:item][:name] != ""
                params[:item][:name].gsub!(/(\b[a-z])+/) {|letter| letter.capitalize}
            end
            if params[:item][:name] == "" || params[:item][:price] == ""
                flash[:data_error] = "You left one of the required fields blank! Please Try again!"
                redirect to '/items/new'
            elsif !!Item.find_by(params[:item])
                flash[:data_error] = "That item already exists!"
                redirect to '/items/new'
            else
                @item = Item.create(params[:item])
                @item.user = current_user
                @item.save
            end
            redirect to "/items/#{@item.id}"
        else
            redirect to '/login'
        end
    end

    get '/items/:id' do
        if logged_in?
            @item = Item.find(params[:id])
            erb :"items/show"
        else
            redirect to "/login"
        end
    end

    get '/items/:id/edit' do
        if logged_in?
            @item = Item.find_by(params[:id])
            if @item && @item.user == current_user
                erb :"items/edit"
            else
                redirect to '/items'
            end
        else
            redirect to '/login'
        end
    end

    patch "/items/:id" do
        if logged_in?
            @item = Item.find(params[:id])
            @item.update(params[:item])
            @item.save
            redirect to ("/items/#{@item.id}")
        else
            redirect to '/login'
        end
    end
end