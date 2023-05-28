class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :food, dependent: :delete_all

  validates :name, { presence: true,  uniqueness: true }
  validates :address, presence: true
end