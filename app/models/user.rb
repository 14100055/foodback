class User < ActiveRecord::Base
    validates :first_name, presence: true, length: {minimum: 1}
    validates :last_name, presence: true, length: {minimum: 1}
    validates :email, presence: true, length: {minimum: 1}, uniqueness: true
    validates :budget, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
    has_secure_password
    
    def self.all_attributes
        puts self.inspect
    end
    
    def self.omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
            user.first_name = auth.info.name.split[0]
            user.last_name = auth.info.name.split[1]
            user.email = auth.info.email
            user.password = auth.uid
            user.save!
        end
    end

end
