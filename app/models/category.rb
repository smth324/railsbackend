class Category < ApplicationRecord
  belongs_to :item
  has_many :types, dependent: :destroy
  validates :name, presence: true
  validates :item_id, presence: true
end
