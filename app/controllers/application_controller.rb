class ApplicationController < ActionController::Base
before_action :set_user?

  def set_user?
    if current_user
    if current_user.has_role? :admin
      @user = current_user # Tomamos el usuario autenticado actualmente
      @restaurants = @user.restaurants # Traemos los restaurantes del usuario autenticado
      @branches = Array.new
      @restaurants.each do |restaurant|
        restaurant.branches.each do |branch| # Recorremos todas las sucursales de un restaurant
            @branches.push(branch) # Pusheamos cada sucursal al array de sucursales
        end 
      end
      @product_score = 0
      @total_sales = 0
    end

    if current_user.has_role? :waiter
      @user = current_user
      @waiterview = AdminWaiterAccount.find_by(id_waiter: @user.id)
      @branch = Branch.find(@waiterview.branch_id)
      @admin = User.find(@waiterview.id_admin)
      @products = @admin.products
      @orders = Array.new
      @reserve = Array.new
      @reviews = Array.new
      @tables = Array.new
      
        if !@branch.orders.blank? # Consultamos si la sucursal tiene ordenes
            @branch.orders.each do |order| # Recorremos las ordenes de la sucursal
                @orders.push(order) # Pusheamos cada orden de cada sucursal al array de ordenes
            end
        end

        @branch.orders.each do |o|
          if o.reserve == nil
            "Orden sin reserva"
          else
            @reserve.push(o.reserve)            
          end
        end

        @branch.tables.each do |table|
            @tables.push(table)
        end

        @products.each do |product|
          if !product.reviews.blank? # Consultamos si el producto tiene reviews
            product.reviews.each do |review| # Recorremos las reviews del producto 
              @reviews.push(review) # Pusheamos cada review al array de reviews
            end
          end
        end
    end

    if current_user.has_role? :cook
      @user = current_user
      @cookview = AdminCookAccount.find_by(id_cook: @user.id)
      @branch = Branch.find(@cookview.branch_id)
      @products = Product.where(user_id: [@cookview.id_admin])
      @admin = User.find(@cookview.id_admin)
      @orders = Array.new
      
      if !@branch.orders.blank? # Consultamos si la sucursal tiene ordenes
          @branch.orders.each do |order| # Recorremos las ordenes de la sucursal
              @orders.push(order) # Pusheamos cada orden de cada sucursal al array de ordenes
          end
      end
    end

    if current_user.has_role? :branch_leader
      @user = current_user
      @branchleader = AdminBranchLeader.find_by(id_leader: @user.id)
      @branch = Branch.find(@branchleader.branch_id)
      @products = Product.where(user_id: [@branchleader.id_admin])
      @admin = User.find(@branchleader.id_admin)
      @restaurants = @admin.restaurants
      @categories = @admin.categories
      @orders = Array.new
      
      if !@branch.orders.blank? # Consultamos si la sucursal tiene ordenes
          @branch.orders.each do |order| # Recorremos las ordenes de la sucursal
              @orders.push(order) # Pusheamos cada orden de cada sucursal al array de ordenes
          end
      end
    end
  end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def after_sign_in_path_for(resource)
    return admin_index_path
  end
  
  def set_locale
    I18n.locale = :es
  end

end
