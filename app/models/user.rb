class User < ApplicationRecord  
    has_many :tasks, dependent: :destroy
    
    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, uniqueness: true
end
