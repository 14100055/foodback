class User < ActiveRecord::Base
    validates :first_name, presence: true, length: {minimum: 1}
    validates :last_name, presence: true, length: {minimum: 1}
    validates :email, presence: true, length: {minimum: 1}, uniqueness: true
    validates :budget, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
    has_secure_password
    
    def self.all_attributes
        puts self.inspect
    end
end
