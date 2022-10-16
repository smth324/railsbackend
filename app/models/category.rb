class Category < ApplicationRecord
  belongs_to :item
  has_many :types, dependent: :destroy
end
