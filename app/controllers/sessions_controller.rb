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
            puts "This is it"
            @breakfast = parse_meals(@user.breakfast)
            @lunch = parse_meals(@user.lunch)
            @dinner = parse_meals(@user.dinner)
            @foods = Food.all
        end
    end

    def compute
        @id = session[:user_id]
        @user = User.find(@id)

        if @user.update(:budget => params[:session][:budget])
            budget = (params[:session][:budget].to_i)/3

            b_start = Time.utc(2000,01,01, 7,00,00)
            b_finish = Time.utc(2000,01,01, 11,00,00)
            # @breakfast = "PDC,Omelette,30\nPDC,Bread,10"
            @breakfast = get_plan(budget, b_start, b_finish)
            @user.update(:breakfast => @breakfast)

            l_start = Time.utc(2000,01,01, 12,30,00)
            l_finish = Time.utc(2000,01,01, 16,00,00)
            # @lunch = "PDC,Omelette,30\nPDC,Bread,10"
            @lunch = get_plan(budget, l_start, l_finish)
            @user.update(:lunch => @lunch)

            d_start = Time.utc(2000,01,01, 19,00,00)
            d_finish = Time.utc(2000,01,01, 23,00,00)
            # @dinner = "PDC,Omelette,30\nPDC,Bread,10"
            @dinner = get_plan(budget, d_start, d_finish)
            @user.update(:dinner => @dinner)

        end
        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

    def parse_meals(meals)
        meal = Hash.new
        m = meals.split("\n")
        i = 0
        m.each do |f|
            food = f.split(",")
            i += 1
            meal[i] = {:restaurant => food[0], :name => food[1], :price => food[2]}
        end
        return meal
    end

    def get_plan(budget, start, finish)
        plan = ""

        foods = Food.where("(start between (?) and (?)) OR (end between (?) and (?)) OR (start < (?) and end > (?)) OR (start < (?) and end < start)", start, finish, start, finish, start, finish, start)
        pdc = Array.new
        foods.each do |food|
            if food.restaurant == "PDC"
                pdc.append(food)
            end
        end
        pdc.each do |side|
            pdc.each do |main|
                if (side.name == "Rice" or side.name == "Roti" or side.name == "Bread") and (main.name != "Rice" and main.name != "Roti" and main.name != "Bread")
                    combo = side
                    combo.name += "+#{main.name}"
                    combo.price += main.price
                    if combo.price <= budget
                        plan += "#{combo.restaurant},#{combo.name},#{combo.price}\n"
                    end
                end
            end
        end
        
        foods.each do |food|
            if food.restaurant != "PDC" and food.price <= budget
                plan += "#{food.restaurant},#{food.name},#{food.price}\n"
            end
        end

        return plan
    end

end
