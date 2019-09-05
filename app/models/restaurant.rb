class Restaurant < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :categories
  has_many :branches, dependent: :destroy
  has_one :bank_account
end
