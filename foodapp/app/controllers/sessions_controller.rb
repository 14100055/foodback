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
        @user = User.find(@id)

        if @user.update(:budget => params[:session][:budget])
            budget = params[:session][:budget].to_i
            plan = get_plan(budget)
            @user.update(:plan => plan)
        end
        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

    def get_plan(budget)
        @morning = Food.where(:start => Time.utc(2000,01,01, 7,00,00)...Time.utc(2000,01,01, 11,00,00))
        morning_money = budget/3
        m_place = Array.new
        m_foods = Array.new
        @morning.each do |food|
            if food.price < morning_money
                m_place.append(food.restaurant)
                m_foods.append(food.name)
            end
        end
        len = m_foods.size
        index = rand(len)
        place = m_place.at(index)
        foods = m_foods.at(index)

        plan = "BREAKFAST: #{place} - #{foods}"
        return plan
    end

end
