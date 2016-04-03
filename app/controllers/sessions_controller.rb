$B_START = Time.utc(2000,01,01, 7,00,00)
$B_FINISH = Time.utc(2000,01,01, 11,00,00)
$L_START = Time.utc(2000,01,01, 12,30,00)
$L_FINISH = Time.utc(2000,01,01, 16,00,00)
$D_START = Time.utc(2000,01,01, 19,00,00)
$D_FINISH = Time.utc(2000,01,01, 23,00,00)

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
            @breakfast = parse_meals(@user.breakfast)
            @lunch = parse_meals(@user.lunch)
            @dinner = parse_meals(@user.dinner)
        end
    end

    def compute
        @id = session[:user_id]
        @user = User.find(@id)

        if !params[:session][:budget].nil?
            update_budget(@user, params[:session][:budget])
        end
        
        if !params[:session][:amount].nil? and !params[:session][:meal].nil?
            edit_budget(@user, params[:session][:amount], params[:session][:meal])
        end

        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

    def update_budget(user, new_budget)
        if user.update(:budget => new_budget)
            budget = (new_budget.to_i)/3

            breakfast = get_plan(budget, $B_START, $B_FINISH)
            user.update(:breakfast => breakfast)

            lunch = get_plan(budget, $L_START, $L_FINISH)
            user.update(:lunch => lunch)

            dinner = get_plan(budget, $D_START, $D_FINISH)
            user.update(:dinner => dinner)
        end
    end
    
    def edit_budget(user, amount, meal)
        amount_used = amount.to_i
        budget = user.budget - amount_used
        user.update(:budget => budget)
        
        if meal == 'Breakfast'
            budget = budget/2
            breakfast = "You have had breakfast,-,#{amount_used}"
            user.update(:breakfast => breakfast)
        elsif meal == 'Lunch'
            lunch = "You have had lunch,-,#{amount_used}"
            user.update(:lunch => lunch)
        elsif meal == 'Dinner'
            dinner = "You have had dinner,-,#{amount_used}"
            user.update(:dinner => dinner)
        elsif meal == 'Miscellaneous'
            breakfast = user.breakfast
            lunch = user.lunch
            dinner  =user.dinner
            meals_eaten = 0
            if(breakfast.include?("You have had breakfast"))
                meals_eaten = meals_eaten + 1;
            end
            if(lunch.include?("You have had lunch"))
                meals_eaten = meals_eaten + 1;
            end
            if(dinner.include?("You have had dinner"))
                meals_eaten = meals_eaten + 1;
            end
            
            if meals_eaten != 3
                budget = (budget)/(3-meals_eaten)
            end
        end

        if(user.breakfast.exclude?("You have had breakfast"))
            breakfast = get_plan(budget, $B_START, $B_FINISH)
            user.update(:breakfast => breakfast)
        end
        if(user.lunch.exclude?("You have had lunch"))
            lunch = get_plan(budget, $L_START, $L_FINISH)
            user.update(:lunch => lunch)
        end
        if(user.dinner.exclude?("You have had dinner"))
            dinner = get_plan(budget, $D_START, $D_FINISH)
            user.update(:dinner => dinner)
        end

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
        sides = ["Rice", "Roti", "Bread"]

        foods = Food.where("((start_at between ? and ?) OR (end_at between ? and ?) OR (start_at < ? and end_at > ?) OR (start_at < ? and end_at < start_at)) AND (price <= ?)", start, finish, start, finish, start, finish, start, budget)
        pdc = Array.new
        non_pdc = Array.new
        foods.each do |food|
            if food.restaurant == "PDC"
                pdc.append(food)
            else
                plan += "#{food.restaurant},#{food.name},#{food.price}\n"
            end
        end
        pdc.each do |side|
            pdc.each do |main|
                if sides.include?(side.name) and !(sides.include(main.name)# == "Rice" or side.name == "Roti" or side.name == "Bread") and !(main.name == "Rice" or main.name == "Roti" or main.name == "Bread")
                    combo = side
                    combo.name += "+#{main.name}"
                    combo.price += main.price
                    if combo.price <= budget
                        plan += "#{combo.restaurant},#{combo.name},#{combo.price}\n"
                    end
                end
            end
        end

        return plan
    end

end
