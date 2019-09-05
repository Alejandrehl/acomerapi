class Order < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  has_and_belongs_to_many :products
  has_one :reserve, dependent: :delete
  has_many :order_details, dependent: :delete_all
  default_scope { order("created_at ASC") }
end
