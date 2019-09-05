class User < ApplicationRecord
  rolify

  has_one_attached :profile
  
  has_many :categories
  has_many :restaurants
  has_many :products
  has_many :reserve

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:operations) if self.email == 'alejandro@acomer.cl'
    self.add_role(:admin) if self.roles.blank?
  end

  has_many :waiter_table
  has_many :table, through: :waiter_table

end
