class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :orders, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :image_product_paths, dependent: :destroy

  def assign_category(category)
    self.categories << Category.find(category.id)
  end
  
end
