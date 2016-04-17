require 'rails_helper'
# require "sessions_controller"

describe SessionsController do
    
    describe 'adding favourites' do
        # before :each do
        #     @user = mock(User, :first_name => "Abdulla", :last_name => "Rafi", :email => "example@gmail.com", :password_digest => "hello@123")
        #     User.stub!(:find).with("1").and_return(@user)
        # end

        before :each do
            user = build(:user)
            # puts user.first_name
        end
        
        it 'should print stuff' do
            user = build(:user)
            puts "Hello"
            puts user.first_name
        end
        # puts user.first_name
        # puts @user.stub!(:find).with("1").and_return(@user)
        # puts @user

        # it 'should call favourites() and redirect' do
        #     @user.stub()

        # it "returns The favourites value in the user table as that string" do
        #     expect(SessionsController.favourites(@user, "chickenRoll,Samosa,Coke")).to eql(@user.favourites)
        # end
    end

end
