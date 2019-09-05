class WaiterTable < ApplicationRecord
    belongs_to :table
    belongs_to :user
end