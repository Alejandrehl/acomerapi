class Category < ApplicationRecord
  resourcify
  belongs_to :user
  has_and_belongs_to_many :products, dependent: :destroy
  has_and_belongs_to_many :menus, through: :categories_menu, dependent: :destroy
  has_one :image_path_category, dependent: :destroy
end
