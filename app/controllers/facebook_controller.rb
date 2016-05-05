class FacebookController < ApplicationController
    
    def create
        user = User.omniauth(env['omniauth.auth'])
        session[:user_id] = user.id
        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

end