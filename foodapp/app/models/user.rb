class User < ActiveRecord::Base
    
    has_secure_password
    
    def self.all_attributes
        puts self.inspect
    end
end
