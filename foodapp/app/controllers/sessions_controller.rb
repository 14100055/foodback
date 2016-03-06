class SessionsController < ApplicationController
    def new
    end
    
    def create
        @user = User.find_by_email(params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to '/mainpage'
        else
            flash[:notice] = "Invalid email/password!"
            redirect_to '/login'
        end
    end
    
    def mainpage
        if session[:user_id].nil?
            redirect_to '/login'
        else
            @id = session[:user_id]
            @user = User.find(@id)
        end
    end
    
    def compute
        @id = session[:user_id]
        User.update(@id, :budget => params[:session][:budget])
        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

end
