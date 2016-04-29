class UsersController < ApplicationController
    def new
        User.all_attributes
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Account created: #{user_params[:email]}"
            redirect_to '/'
        else
            flash[:notice] = "Input information properly"
            redirect_to '/signup'
        end
    end
    
private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
    
end
