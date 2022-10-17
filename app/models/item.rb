class Item < ApplicationRecord
  belongs_to :store
  has_many :categories, dependent: :destroy
  validates :name, presence: true
  validates :store_id, presence: true
end
