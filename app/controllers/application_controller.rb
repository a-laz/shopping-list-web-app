class ApplicationController < Sinatra::Base
    configure do
        set :views, proc { File.join(root, "../views/") }
        enable :sessions
        set :session_secret, "shopping_web_app"
        
    end

    get '/' do
        erb :"application/index"
    end

    helpers do
        def logged_in?
            !!current_user
        end

        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end
    end
end