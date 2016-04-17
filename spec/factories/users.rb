FactoryGirl.define do
    factory :user do |f|
        f.first_name "Abdulla"
        f.last_name "Rafi"
        f.email "example@email.com"
        f.password_digest "asdf"
    end
end