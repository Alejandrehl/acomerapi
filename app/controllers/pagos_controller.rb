class PagosController < ApplicationController
  def index
    @orders_per_branches = Order.where(branch_id: params[:id])
  end

  def payment
    @payment = BankAccount.new
    @payment.business_name = params[:business_name]
    @payment.business_rut = params[:business_rut]
    @payment.business_email = params[:business_email]
    @payment.bank_name = params[:bank_name]
    @payment.account_type = params[:account_type]
    @payment.account_number = params[:account_number]
    @payment.restaurant_id = params[:restaurant_id]
    @payment.save
    redirect_to admin_index_path
  end

  def detail
    @restaurant = Restaurant.find(params[:id])
    @payment = BankAccount.find_by(restaurant_id: @restaurant.id)
    @products = current_user.products
    @total_sales = 0 # Creamos la varibale que va almacenar el total de todas las ventas
    @restaurant_score = 0
    @orders = Array.new
    @reviews = Array.new
    @products.each do |product|
      if !product.reviews.blank? # Consultamos si el producto tiene reviews
        product.reviews.each do |review| # Recorremos las reviews del producto 
          @reviews.push(review) # Pusheamos cada review al array de reviews
        end
      end
    end
    @restaurant.branches.each do |branch|
      if !branch.orders.blank? # Consultamos si la sucursal tiene ordenes
          branch.orders.each do |order| # Recorremos las ordenes de la sucursal
              @orders.push(order) # Pusheamos cada orden de cada sucursal al array de ordenes
          end
      end
    end
    @orders.each do |order|
      @total_sales += order.total # Sumamos el total de cada orden y lo vamos almacenando y actualizando en la variable @total_sales
    end
  end

  def send_mail
    @user = current_user
    @payment = BankAccount.find_by(restaurant_id: params[:restaurant_bill])
    UserMoneyBackMailer.send_money_email(@user, @payment).deliver
    redirect_to admin_index_path
  end

  def delete
    @payment = BankAccount.find_by(restaurant_id: params[:id])
    @payment.destroy
    redirect_to admin_index_path
  end

end
