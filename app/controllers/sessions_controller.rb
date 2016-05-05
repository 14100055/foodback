require 'date'
$B_START = Time.utc(2000,01,01, 7,00,00)
$B_FINISH = Time.utc(2000,01,01, 11,00,00)
$L_START = Time.utc(2000,01,01, 12,30,00)
$L_FINISH = Time.utc(2000,01,01, 16,00,00)
$D_START = Time.utc(2000,01,01, 19,00,00)
$D_FINISH = Time.utc(2000,01,01, 23,00,00)
$E_START = Time.utc(2000,01,01, 23,31,00)
$E_FINISH = Time.utc(2000,01,01, 23,51,00)

# Login through Facebook

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

    def profile
        session[:profile] = true
        @id = session[:user_id]
        @user = User.find(@id)
        @days = @user.days.split(",")
        @moneySpent = @user.money_spent.split(",").map{ |x| x.to_i }
    end

    def mainpage
        if session[:user_id].nil?
            redirect_to '/login'
        else
            session[:profile] = false
            @id = session[:user_id]
            @user = User.find(@id)
            @exotic = parse_meals(@user.exotic)
            @breakfast = parse_meals(@user.breakfast)
            @lunch = parse_meals(@user.lunch)
            @dinner = parse_meals(@user.dinner)
            @foods = Food.pluck('DISTINCT restaurant, name, price')
            
            @favourites = Array.new
            favs = @user.favourites.split("\n")
            favs.each do |fav|
                f = fav.split(",")
                @favourites.append("#{f[0]}_#{f[1]}")
            end
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

    def update_budget
        id = session[:user_id]
        user = User.find(id)

        if user.update(:original_budget => params[:session][:budget])
            user.update(:good_days => 0)
            user.update(:bad_days => 0)
            user.update(:remaining_days => 30)

            original_budget = user.original_budget
            budget = original_budget/30

            user.update(:month_budget => original_budget - budget)
            user.update(:budget => budget)
            user.update(:meals => 3)
            update_meals(user, budget/3)
            
            user.update(:daily_spent => 0)
            user.update(:days => "")
            user.update(:money_spent => "")
            
            if (params[:session][:split_budget]!="" && params[:session][:deadline]!="")
                user.update(:split_budget => params[:session][:split_budget])
                user.update(:deadline => params[:session][:deadline])
                user.update(:month_budget => original_budget - user.split_budget)
                user.update(:budget => (user.split_budget / user.deadline))
                user.update(:split_budget => (user.split_budget - user.budget))
            end
        end

        redirect_to '/mainpage'
    end
    
    def input_meal
        id = session[:user_id]
        user = User.find(id)

        if user.update(:budget => (user.budget - (params[:session][:amount].to_i)))
            user.daily_spent = user.daily_spent + params[:session][:amount].to_i
            amount = params[:session][:amount].to_i
            budget = user.budget.to_i
            meal = params[:session][:meal]

            if meal == 'Breakfast'
                user.update(:meals => 2)
                breakfast = "You have had breakfast,-,#{amount}"
                user.update(:breakfast => breakfast)
            elsif meal == 'Lunch'
                user.update(:meals => 1)
                lunch = "You have had lunch,-,#{amount}"
                user.update(:lunch => lunch)
            elsif meal == 'Dinner'
                user.update(:meals => 0)
                dinner = "You have had dinner,-,#{amount}"
                user.update(:dinner => dinner)
            end

            budget = budget / (user.meals.nonzero? || 1)
            update_meals(user, budget)
        end
        
        redirect_to '/mainpage'
    end

    def favourites
        id = session[:user_id]
        user = User.find(id)

        favs = params[:foods].keys
        favourites = ""
        favs.each do |food|
            favourites << "#{food}\n"
        end
        user.update(:favourites => favourites)
        
        redirect_to '/mainpage'
    end

    def new_day
        id = session[:user_id]
        user = User.find(id)

        if user.remaining_days != -1
            if user[:budget] >= 0
                user.update(:good_days => user[:good_days]+1)
            else
                user.update(:bad_days => user[:bad_days]+1)
            end
            
            user.update(:remaining_days => (user.remaining_days-1))
            user.update(:deadline => (user.deadline-1))

            if(user.deadline <= 0)
                month_budget = user.budget + user.month_budget + user.split_budget
                budget = month_budget / user.remaining_days
                user.update(:split_budget => 0)
                user.update(:month_budget => (month_budget - budget))
            else 
                split_budget = user.split_budget + user.budget
                budget = split_budget / user.deadline
                user.update(:split_budget => (split_budget - budget))
            end

            user.update(:days => (user.days + "," + (30 - user.remaining_days).to_s))
            user.update(:money_spent => (user.money_spent + "," + user.daily_spent.to_s))
            user.update(:daily_spent => 0)

            user.update(:budget => budget)
            user.update(:meals => 3)
            update_meals(user, budget/3)
        end
        
        redirect_to '/mainpage'
    end


    def update_meals(user, budget)
        if user.meals >= 3
            breakfast = get_plan(budget, $B_START, $B_FINISH)
            user.update(:breakfast => breakfast)
        end

        if user.meals >= 2
            lunch = get_plan(budget, $L_START, $L_FINISH)
            user.update(:lunch => lunch)
        end

        if user.meals >= 1
            dinner = get_plan(budget, $D_START, $D_FINISH)
            user.update(:dinner => dinner)
        end
        
        if user.remaining_days == 1
            exotic = get_luxury(500, $E_START, $E_FINISH)
            user.update(:exotic => exotic)
        else
            user.update(:exotic => "It's not the last day of the month yet. :(")
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
        fillers = ["Bread", "Rice", "Roti"]

        foods = Food.where("((start_at between ? and ?) OR (end_at between ? and ?) OR (start_at < ? and end_at > ?) OR (start_at < ? and end_at < start_at)) AND (price <= ?)", start, finish, start, finish, start, finish, start, budget)
        sides = Array.new
        mains = Array.new
        foods.each do |food|
            if food.restaurant == "PDC"
                sides.append(food)
                mains.append(food)
            else
                plan << "#{food.restaurant},#{food.name},#{food.price}\n"
            end
        end
        sides.each do |side|
            if fillers.include?(side.name)
                mains.each do |main|
                    if !(fillers.include?(main.name))
                        name = "#{side.name}+#{main.name}"
                        price = side.price+main.price
                        if price <= budget
                            plan << "PDC,#{name},#{price}\n"
                        end
                    end
                end
            end
        end

        return plan
    end
    
    def get_luxury(budget, start, finish)
        plan = ""
        lums = ["PDC", "Khokha", "Superstore"]
        
        foods = Food.where("((start_at between ? and ?) OR (end_at between ? and ?) OR (start_at < ? and end_at > ?) OR (start_at < ? and end_at < start_at)) AND (price <= ?)", start, finish, start, finish, start, finish, start, budget)
        foods.each do |food|
            if !lums.include?(food.restaurant)
                plan << "#{food.restaurant},#{food.name},#{food.price}\n"
            end
        end

        return plan
    end

end
