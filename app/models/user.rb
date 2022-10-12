class User < ApplicationRecord
    has_many :stores
    validates :email, presence: true
    validates :passwordHash, presence: true
end
