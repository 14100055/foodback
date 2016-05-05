# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

foods = [   {:restaurant => 'Khokha', :name => 'Cheese roll', :price => 120, :start_at => '09:00', :end_at => '05:00'},
            {:restaurant => 'Khokha', :name => 'Mayo roll', :price => 120, :start_at => '09:00', :end_at => '05:00'},
            {:restaurant => 'Khokha', :name => 'Chicken roll', :price => 100, :start_at => '09:00', :end_at => '05:00'},
            {:restaurant => 'PDC', :name => 'Omelette', :price => 30, :start_at => '07:00', :end_at => '10:30'},
            {:restaurant => 'PDC', :name => 'Bread', :price => 10, :start_at => '07:00', :end_at => '10:30'},
            {:restaurant => 'PDC', :name => 'Rice', :price => 50, :start_at => '13:00', :end_at => '15:30'},
            {:restaurant => 'PDC', :name => 'Roti', :price => 10, :start_at => '13:00', :end_at => '15:30'},
            {:restaurant => 'PDC', :name => 'Chicken', :price => 120, :start_at => '13:00', :end_at => '15:30'},
            {:restaurant => 'PDC', :name => 'Daal', :price => 35, :start_at => '13:00', :end_at => '15:30'},
            {:restaurant => 'PDC', :name => 'Rice', :price => 50, :start_at => '19:00', :end_at => '22:30'},
            {:restaurant => 'PDC', :name => 'Roti', :price => 10, :start_at => '19:00', :end_at => '22:30'},
            {:restaurant => 'PDC', :name => 'Chicken', :price => 120, :start_at => '19:00', :end_at => '22:30'},
            {:restaurant => 'PDC', :name => 'Daal', :price => 35, :start_at => '19:00', :end_at => '22:30'},
            {:restaurant => 'Chop Chop', :name => 'Chowmein', :price => 170, :start_at => '13:00', :end_at => '23:30'},
            {:restaurant => 'Chop Chop', :name => 'Tamarind', :price => 240, :start_at => '13:00', :end_at => '23:30'},
            {:restaurant => 'Chop Chop', :name => 'Mongolian', :price => 240, :start_at => '13:00', :end_at => '23:30'},
            {:restaurant => 'Chop Chop', :name => 'Fried fish', :price => 160, :start_at => '13:00', :end_at => '23:30'},
            {:restaurant => 'Superstore', :name => 'Roll', :price => 130, :start_at => '10:00', :end_at => '01:00'},
            {:restaurant => 'Superstore', :name => 'Shawarma', :price => 120, :start_at => '10:00', :end_at => '01:00'},
            {:restaurant => 'Superstore', :name => 'Pizza', :price => 60, :start_at => '10:00', :end_at => '01:00'},
            {:restaurant => 'Superstore', :name => 'Burger', :price => 200, :start_at => '10:00', :end_at => '01:00'},
            {:restaurant => 'Superstore', :name => 'Sandwich', :price => 180, :start_at => '10:00', :end_at => '01:00'},
            {:restaurant => 'Bomnbay', :name => 'Chicken Burger', :price => 350, :start_at => '23:35', :end_at => '23:55'},
            {:restaurant => 'Subway', :name => 'Sandwich', :price => 400, :start_at => '23:35', :end_at => '23:55'},
            {:restaurant => 'Jammin Java', :name => 'Pasta', :price => 400, :start_at => '23:35', :end_at => '23:55'},
            {:restaurant => 'Bomnbay', :name => 'Beef Burger', :price => 430, :start_at => '23:35', :end_at => '23:55'},
            {:restaurant => 'Jammin Java', :name => 'Sandwich', :price => 400, :start_at => '23:35', :end_at => '23:55'}
            
]

Food.delete_all
User.delete_all

foods.each do |food|
    Food.create!(food)
end