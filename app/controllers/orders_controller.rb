class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource :except => [:show]
  skip_before_action :verify_authenticity_token

  # GET /orders 
  # GET /orders.json
  def index
    @branches = Array.new
    @orders = Array.new

    @restaurants.each do |r|
      r.branches.each do |b|
        @branches.push(b)
      end 
    end

    @restaurants.each do |r|
      r.branches.each do |b|
        b.orders.each do |o|
          if o == nil
            "Branch sin ordenes"
          else
            @orders.push(o)            
          end
        end 
      end 
    end
  end

  # GET /orders_branches.json
  def branch
    @branch = Branch.find(params[:id])
    @orders_per_branches = @branch.orders.where.not(status: 'completed')
    # @requested = @orders_per_branches.where(status: 'requested')
    # @in_process = @orders_per_branches.where(status: 'process')
    # @ready = @orders_per_branches.where(status: 'ready')   
  end

  def changestatus
    @orders_per_branches = Order.find(params[:id])

    if @orders_per_branches.status == 'requested'
      @orders_per_branches.update_attributes(status: 'paying')
      redirect_back fallback_location: { controller: "orders", action: "branch", id: @orders_per_branches.branch_id}
    elsif @orders_per_branches.status == 'paying'
      @orders_per_branches.update_attributes(status: 'completed')
      redirect_back fallback_location: { controller: "orders", action: "branch", id: @orders_per_branches.branch_id}
    end
  
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  # POST /orders_branches.json
  def create
    @products = params[:products]
    puts @products
    # Crear Array de productos
    products = Array.new
    # Buscar productos que llegan desde el front.
    @products.each do |p|
      product = Product.find(p[:id])
      quantity = p[:quantity]
      quantity.times do
        products.push(product)
      end
    end

    @order = Order.new
    @order.payed = params[:payed]

    @order.payment_modality = params[:payment_modality]

    # Comparar totales.
    total = 0
    products.each do |p|
      if total == 0
        total = p.price
      else
        total += p.price
      end
    end
    
    if total == params[:total].to_i
      @order.total = total
    else
      respond_to do |format|
        format.json { render :json => { :status => "error", :message => 'El total no es correcto'} and return } 
      end
    end
    

    @order.status = params[:status]
    if params[:reservation] == 'yes'
      @order.reservation = params[:reservation]
    end
  
    @order.specification = params[:specification]
      # Buscar a usuario.
    if User.exists?(params[:user_id])
      @order.user_id = params[:user_id]
    else
      respond_to do |format|
      # Retornar mensaje de error indicando que el usuario no éxiste en la base de datos.
        format.json { render :json => { :status => "error", :message => 'El usuario no existe'} and return } 
      end
    end
  
    # Buscar menú.
    if Menu.exists?(params[:menu_id])
      @menu = Menu.find(params[:menu_id])
      @order.branch_id = @menu.branch_id
    else
      respond_to do |format|
        # Retornar mensaje de error indicando que le menu no existe en la base de datos.
        format.json { render :json => { :status => "error", :message => 'El menu no existe'} and return } 
      end
    end

    if params[:table_id] == 0
      # buscca mesa 0 de este branch
      @table = Table.find_by(branch_id: @order.branch_id, description: 'Mesa Predeterminada')
      @order.tables_id = @table.id
    else
      @order.tables_id = params[:table_id]
    end
  
    respond_to do |format|
      if @order.save
        # Agregar datos a tabla muchos a muchos orders_products}        
        products.each do |p|
          @order.products << p
        end

        if @order.reservation == "yes"
          @reservation = Reserve.new
          @reservation.mode = params[:reservationData][:tipo]
          @reservation.reservation_day = params[:reservationData][:day]
          @reservation.reservation_hour = params[:reservationData][:hour]
          @reservation.number_people = params[:reservationData][:people]
          @reservation.user_id = params[:user_id]
          @reservation.order_id = @order.id
          @reservation.save
        end
        
        puts @products
  
        @products.each do |p|
          product = Product.find(p[:id])
          @order_detail = OrderDetail.new
          @order_detail.order_id = @order.id
          @order_detail.product_id = product.id
          @order_detail.quantity = p[:quantity]
          @order_detail.save
        end
        @product_table = ''
        @order.order_details.each do |detail|
          @product_table = @product_table+"<tr><td>#{detail.product.name}</td><td>#{detail.quantity}</td><td>#{detail.product.price * detail.quantity}</td></tr>"
        end

        ActionCable.server.broadcast 'notifications_channel',
        id: @order.id

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :json => { :reservation => @reservation, :orden => @order } and return }
      else
        format.html { render :new }
        format.json { render json: @order.errors.full_message, status: :unprocessable_entity }
      end
    end

  end

  def transaction
    @order = Order.find(params[:id])
    # @order.status = params[:status]
    @order.payment_method =params[:payment_method]
    @order.payed = params[:payed]
    @order.transaction_id = params[:transaction_id]
    @order.save
  end

  def transaction_edit
    @order = Order.find_by(transaction_id: params[:transaction_id])
    # @order.status = params[:status]
    @order.payment_method =params[:payment_method]
    @order.payed = params[:payed]
    @order.save
  end

  # /orders/history/id
  def history
    @orders = Order.where(branch_id: params[:id], status: 'completed') 
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @old_status = @order.status
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }

        ActionCable.server.broadcast 'order_status_handler_channel',
        order_id: @order.id,
        old_status: @old_status,
        new_status: @order.status

      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:total, :payment_method, :status, :specification, :reservation, :user_id, :branch_id, :payed, :tables_id, :transaction_id, product_ids:[])
    end
end
