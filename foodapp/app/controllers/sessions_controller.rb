class SessionsController < ApplicationController
    def new
    end
    
    def create
        @user = User.find_by_email(params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to '/mainpage'
        else
            redirect_to 'login'
        end
    end
    
    def mainpage
        @id = session[:user_id]
        @user = User.find(@id)
        puts "Printing..."
        puts @user.budget
        puts "Printed"
    end
    
    def compute
        @budget = params[:session][:budget].to_i
        @id = session[:user_id]
        if @user = User.where(:id => @id)
            User.update(@id, :budget => @budget)
        end
        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end
end
