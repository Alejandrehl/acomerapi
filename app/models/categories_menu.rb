class CategoriesMenu < ApplicationRecord
  belongs_to :category,dependent: :destroy
  belongs_to :menu,dependent: :destroy
end
