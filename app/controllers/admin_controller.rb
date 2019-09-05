class AdminController < ApplicationController
    before_action :authenticate_user! # Solo se puede acceder a los métodos de este controlador con un usuario autenticado

    def index
        @user = current_user
        @restaurants = @user.restaurants
        @products = @user.products
        @tables = Array.new
        @orders = Array.new 
        @reviews = Array.new
        @branches = Array.new
        @products.each do |product|
          if !product.reviews.blank? # Consultamos si el producto tiene reviews
            product.reviews.each do |review| # Recorremos las reviews del producto 
              @reviews.push(review) # Pusheamos cada review al array de reviews
            end
          end
        end
        @restaurants.each do |restaurant|
          restaurant.branches.each do |branch| # Recorremos todas las sucursales de un restaurant
            @branches.push(branch) # Pusheamos cada sucursal al array de sucursales
          end 
        end
        @branches.each do |branch|
          if !branch.orders.blank? # Consultamos si la sucursal tiene ordenes
            branch.orders.each do |order| # Recorremos las ordenes de la sucursal
              @orders.push(order) # Pusheamos cada orden de cada sucursal al array de ordenes
            end
          end
        end
        @restaurants.each do |r|
            r.branches.each do |b|
                b.tables.each do |t|
                    @tables.push(t)
                end 
            end 
        end
        @orders.each do |order|
          @total_sales += order.total # Sumamos el total de cada orden y lo vamos almacenando y actualizando en la variable @total_sales
        end
        if !@reviews.blank?
          @restaurant_score = @reviews.pluck(:stars).sum / @reviews.size.to_f
        end
    end

    def restaurants 
    end

    def branches
      @user = current_user
      @restaurants = @user.restaurants
      @branches = Array.new
  
      @restaurants.each do |r|
        r.branches.each do |b|
          @branches.push(b)
        end 
      end
    end

    def products
        if current_user.has_role? :admin
            @products = @user.products
        elsif current_user.has_role? :waiter
            @products = Product.where(user_id: [@waiterview.id_admin])
        elsif current_user.has_role? :cook
            @products = Product.where(user_id: [@cookview.id_admin])
        end
    end

    def categories
      if current_user.has_role? :admin
        @categories = @user.categories
      end
    end

    def menus
      if current_user.has_role? :admin
        @menus = Array.new
        @restaurants.each do |r|
          r.branches.each do |b|
            b.menus.each do |m|
              @menus.push(m)
            end 
          end 
        end
      elsif
        @menus = Array.new
        @branch.menus.each do |m|
          @menus.push(m)
        end 
      end
    end

    def orders
    end

    def reviews
        @reviews = Array.new
        current_user.products.each do |product|
            if !product.reviews.blank?
                product.reviews.each do |review|
                @reviews.push(review)
                end
            end
        end
    end

    def tables
      @branches = Array.new
      @tables = Array.new
  
      @restaurants.each do |r|
        r.branches.each do |b|
          @branches.push(b)
        end 
      end
  
      @restaurants.each do |r|
        r.branches.each do |b|
          b.tables.each do |t|
              @tables.push(t)
          end 
        end 
      end
    end

    def instructions
    end

    def waiters
      @branches = Array.new  
      @restaurants.each do |r|
        r.branches.each do |b|
          @branches.push(b)
        end 
      end
    end

    def cooks
      @branches = Array.new  
      @restaurants.each do |r|
        r.branches.each do |b|
          @branches.push(b)
        end 
      end
    end

end
