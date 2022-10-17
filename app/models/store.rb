class Store < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true
  validates :user_id, presence: true
end
