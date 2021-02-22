require 'rack-flash'

class UserController < ApplicationController
    use Rack::Flash

    get '/signup' do
        if !logged_in?
            erb:"users/signup"
        else
            redirect to '/shopping_lists'
        end
    end

    post '/signup' do 
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            flash[:missing_data] = "Cannot leave any fields blank!"
            redirect to '/signup'
        elsif !!User.find_by(:email => params[:email])
            flash[:existing_user] = "A user with that email already exists"
            redirect to '/signup'
        else
            @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
            redirect to '/login'
        end
    end

    get '/login' do
        if !logged_in?
            erb :"users/login"
        else
            redirect to '/shopping_lists'
        end
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/shopping_lists'
        else
            flash[:login] = "Either your Email or Password is wrong"
            redirect to '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end

end