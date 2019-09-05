class ReserveController < ApplicationController
  def index
    @user = current_user
    @restaurants = @user.restaurants
    @branches = Array.new
    @reserve = Array.new

    @restaurants.each do |r|
      r.branches.each do |b|
        @branches.push(b)
      end 
    end
  
    @restaurants.each do |r|
      r.branches.each do |b|
        b.orders.each do |o|
          if o.reserve == nil
            "Orden sin reserva"
          else
            @reserve.push(o.reserve)            
          end
        end 
      end 
    end
  end

  def branch
    @orders_per_branches = Order.where(branch_id: params[:id])
  
    @requested =[]
    @close = []
    @ready = []
    @completed = []
    @orders_per_branches.each do |o|
      if o.reserve == nil
        "Orden sin reserva"
      elsif o.status == "requested"
        # Valida si la reserva es para hoy
        if o.reserve.reservation_day.today?
          # Esta dentro de las proximas dos horas?
          if o.reserve.reservation_hour.hour <= Time.now.hour + 2
            @close.push(o.reserve)
          else
            @requested.push(o.reserve)
          end
        else
          @requested.push(o.reserve)
        end

      elsif o.status == "ready"
        @ready.push(o.reserve)
      elsif o.status == "completed"
        @completed.push(o.reserve)
      end
    end

  

    @url_env = 'https://acomeradmin.cl'
    # @qr = RQRCode::QRCode.new("#{@url_env}/reserve/index?id_reserve=#{params[:id_reserve]}").to_img.resize(150, 150).to_data_url
  end

  def show
    if params[:transaction_id]  
      Order.find_by(transaction_id: params[:transaction_id])
      @reserve = Reserve.find_by(order_id: Order.find_by(transaction_id: params[:transaction_id]).id )
    elsif params[:id]
      @reserve = Reserve.find(params[:id])
    end

    # @url_env = 'http://localhost:4000'
    @url_env = 'https://acomeradmin.cl'
    @qr = RQRCode::QRCode.new("#{@url_env}/reserve/#{params[:id]}").to_img.resize(150, 150).to_data_url
  end
end
