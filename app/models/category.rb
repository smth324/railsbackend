class Category < ApplicationRecord
  belongs_to :store
  has_many :types
end
