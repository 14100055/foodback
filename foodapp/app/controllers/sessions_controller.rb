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

            @breakfast = Hash.new
            b = @user.breakfast.split("\n")
            i = 0
            b.each do |f|
                food = f.split(",")
                i += 1
                @breakfast[i] = {:restaurant => food[0], :name => food[1], :price => food[2]}
            end

            @lunch = Hash.new
            l = @user.lunch.split("\n")
            i = 0
            l.each do |f|
                food = f.split(",")
                i += 1
                @lunch[i] = {:restaurant => food[0], :name => food[1], :price => food[2]}
            end

            @dinner = Hash.new
            d = @user.dinner.split("\n")
            i = 0
            d.each do |f|
                food = f.split(",")
                i += 1
                @dinner[i] = {:restaurant => food[0], :name => food[1], :price => food[2]}
            end

            # @breakfasts.each do |k, v|
            #     puts v[:restaurant]
            #     puts v[:name]
            #     puts v[:price]
            # end
        end
    end
    
    def compute
        @id = session[:user_id]
        @user = User.find(@id)

        if @user.update(:budget => params[:session][:budget])

            b_start = Time.utc(2000,01,01, 7,00,00)
            b_finish = Time.utc(2000,01,01, 11,00,00)
            @breakfast = get_plan(params[:session][:budget], b_start, b_finish)
            @user.update(:breakfast => @breakfast)

            l_start = Time.utc(2000,01,01, 12,30,00)
            l_finish = Time.utc(2000,01,01, 16,00,00)
            @lunch = get_plan(params[:session][:budget], l_start, l_finish)
            @user.update(:lunch => @lunch)

            d_start = Time.utc(2000,01,01, 19,00,00)
            d_finish = Time.utc(2000,01,01, 23,00,00)
            @dinner = get_plan(params[:session][:budget], d_start, d_finish)
            @user.update(:dinner => @dinner)

        end
        redirect_to '/mainpage'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end

    def get_plan(budget, start, finish)
        budget = budget.to_i

# Comment.find(:all, :conditions => {:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day})
        # foods = Food.where(:start => start...finish)# or :end => start...finish)
        # foods = Food.find(:all, :conditions => {:start => start...finish}, {:end => start...finish})
        foods = Food.where("(start between (?) and (?)) OR (end between (?) and (?)) OR (start < (?) and end > (?)) OR (start < (?) and end < start)", start, finish, start, finish, start, finish, start)
        # DATE BETWEEN '09/16/2010 05:00:00' and '09/21/2010 09:00:00'
        # foods.each do |food|
        #     puts food.name
        # end
        pdc = Array.new
        foods.each do |food|
            if food.restaurant == "PDC"
                pdc.append(food)
            end
        end
        combos = Array.new
        pdc.each do |side|
            pdc.each do |main|
                if (side.name == "Rice" or side.name == "Roti" or side.name == "Bread") and (main.name != "Rice" and main.name != "Roti" and main.name != "Bread")
                    combo = side
                    combo.name += "+#{main.name}"
                    combo.price += main.price
                    combos.append(combo)
                end
            end
        end
        
        money = budget/3
        breakfasts = Array.new
        combos.each do |food|
            if food.price < money
                breakfasts.append(food)
            end
        end
        foods.each do |food|
            if food.restaurant != "PDC" and food.price < money
                puts food.name
                breakfasts.append(food)
            end
        end
        plan = ""
        breakfasts.each do |food|
            plan += "#{food.restaurant},#{food.name},#{food.price}\n"
        end

        return plan
    end

end
