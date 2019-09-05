class Menu < ApplicationRecord
  belongs_to :branch
  has_and_belongs_to_many :categories, through: :categories_menu, dependent: :destroy
end
