class Type < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :category_id, presence: true
  validates :unit, presence: true
  validates :price, presence: true
end
