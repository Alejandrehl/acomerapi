class Branch < ApplicationRecord
  resourcify
  belongs_to :restaurant
  has_many :categories
  has_many :menus, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_one :admin_waiter_accounts
  has_many :image_paths, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :admin_branch_leader
end
