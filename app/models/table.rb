class Table < ApplicationRecord
  belongs_to :branch
  has_many :waiter_calls

  has_many :waiter_table
  has_many :user, through: :waiter_table

end
