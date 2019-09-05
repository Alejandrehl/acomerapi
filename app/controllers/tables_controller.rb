class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  # GET /tables
  # GET /tables.json
  def index
    @user = current_user
    @restaurants = @user.restaurants
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

  def branch
    @branch = Branch.find(params[:id])
    @tables = Table.where(branch_id: @branch.id)
  end

  def tablebranch
    @tables_per_branches = Table.where(branch_id: params[:id])
    @tables = Array.new
    @tables_per_branches.each do |t|
      if t == nil
        "No hay Mesa"
      else
        @tables.push(t)
      end
    end
  end

  def menu
    @tables = Menu.find(params[:id]).branch.tables
  end

  # GET /tables/1
  # GET /tables/1.json
  def show
    @branch = Table.find(params[:id]).branch
    @qr = RQRCode::QRCode.new( "https://acomerapp.cl/sucursales/#{@branch.id}?idmesa=#{params[:id]}").to_img.resize(200, 200).to_data_url
  end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
  end

  def waiterview
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(table_params)
    respond_to do |format|
      if @table.save

        if params[:waiter]
          @waitertable = WaiterTable.new
          @waitertable.user_id = params[:waiter]
          @waitertable.table_id = @table.id
          @waitertable.save
          @table.assign = true
          @table.save
          
        end
        
        format.html { redirect_to @table, notice: 'Mesa creada correctamente.' }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        if params[:waiter]
          @waitertable = WaiterTable.find_by(table_id: @table.id)
          @waitertable.user_id = params[:waiter]
          @waitertable.save
        end
        format.html { redirect_to @table, notice: 'Mesa actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @waitertable = WaiterTable.where("table_id = #{@table.id}")
    @waitertable.delete_all
    @table.destroy
    respond_to do |format|
      format.html { redirect_to tables_url, notice: 'Mesa eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_params
      params.require(:table).permit(:description, :state, :branch_id, :number, :assign)
    end
end
