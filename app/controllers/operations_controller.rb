class OperationsController < ApplicationController
    def users
        @users = User.order(id: :desc)
    end

    def orders
        @orders = Order.order(id: :desc)
    end

    def restaurants
        @restaurants = Restaurant.order(id: :desc)
    end

    def featured_branches
        @featured_branches = FeaturedBranch.order(id: :desc)
    end
end
