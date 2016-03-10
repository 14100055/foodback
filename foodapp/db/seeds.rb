# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

foods = [   {:restaurant => 'Khokha', :name => 'Cheese roll', :price => 120, :start => '09:00', :end => '05:00'},
            {:restaurant => 'Khokha', :name => 'Mayo roll', :price => 120, :start => '09:00', :end => '05:00'},
            {:restaurant => 'Khokha', :name => 'Chicken roll', :price => 100, :start => '09:00', :end => '05:00'},
            {:restaurant => 'Khokha', :name => 'Shawarma', :price => 140, :start => '09:00', :end => '05:00'},
]

foods.each do |food|
    Food.create!(food)
end