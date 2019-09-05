class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:show]
  require 'rqrcode'
  include ApplicationHelper
  # GET /branches
  # GET /branches.json
  def index
    @user = current_user
    @restaurants = @user.restaurants
    @branches = Array.new

    @restaurants.each do |r|
      r.branches.each do |b|
        @branches.push(b)
      end 
    end
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
    @branch = Branch.find(params[:id])
    @menus = @branch.menus
    @tables = @branch.tables
    @orders_per_branches = Order.where(branch_id: params[:id])
    # @pending =  @orders_per_branches
    # @url_env = 'http://localhost:3000'
    @url_env = 'https://acomerapp.cl'
    @qr = RQRCode::QRCode.new( "#{@url_env}/sucursales/#{params[:id]}").to_img.resize(200, 200).to_data_url
    
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params)
    # @por_mesas = params[:branch][:al_paso]
    respond_to do |format|
      if @branch.save

        if params[:branch][:hour_op_mon].present? && params[:branch][:hour_cl_mon].present?
          @monday = Schedule.new
          @monday.day = params[:branch][:day_lun]
          @monday.opening = params[:branch][:hour_op_mon]
          @monday.closing = params[:branch][:hour_cl_mon]
          @monday.branch_id = @branch.id
          @monday.save
        end

        if params[:branch][:hour_op_tue].present? && params[:branch][:hour_cl_tue].present?
          @tuesday = Schedule.new
          @tuesday.day = params[:branch][:day_mar]
          @tuesday.opening = params[:branch][:hour_op_tue]
          @tuesday.closing = params[:branch][:hour_cl_tue]
          @tuesday.branch_id = @branch.id
          @tuesday.save
        end

        if params[:branch][:hour_op_wed].present? && params[:branch][:hour_cl_wed].present?
          @wednesday = Schedule.new
          @wednesday.day = params[:branch][:day_mie]
          @wednesday.opening = params[:branch][:hour_op_wed]
          @wednesday.closing = params[:branch][:hour_cl_wed]
          @wednesday.branch_id = @branch.id
          @wednesday.save
        end

        if params[:branch][:hour_op_thu].present? && params[:branch][:hour_cl_thu].present?
          @thursday = Schedule.new
          @thursday.day = params[:branch][:day_jue]
          @thursday.opening = params[:branch][:hour_op_thu]
          @thursday.closing = params[:branch][:hour_cl_thu]
          @thursday.branch_id = @branch.id
          @thursday.save
        end

        if params[:branch][:hour_op_fri].present? && params[:branch][:hour_cl_fri].present?
          @friday = Schedule.new
          @friday.day = params[:branch][:day_vie]
          @friday.opening = params[:branch][:hour_op_fri]
          @friday.closing = params[:branch][:hour_cl_fri]
          @friday.branch_id = @branch.id
          @friday.save
        end

        if params[:branch][:hour_op_sat].present? && params[:branch][:hour_cl_sat].present?
          @saturday = Schedule.new
          @saturday.day = params[:branch][:day_sab]
          @saturday.opening = params[:branch][:hour_op_sat]
          @saturday.closing = params[:branch][:hour_cl_sat]
          @saturday.branch_id = @branch.id
          @saturday.save
        end

        if params[:branch][:hour_op_sun].present? &&  params[:branch][:hour_cl_sun].present?
          @sunday = Schedule.new
          @sunday.day = params[:branch][:day_dom]
          @sunday.opening = params[:branch][:hour_op_sun]
          @sunday.closing = params[:branch][:hour_cl_sun]
          @sunday.branch_id = @branch.id
          @sunday.save
        end

        @al_paso = @branch.step

        if params[:branch][:img_url].present?
          params[:branch][:img_url].each do |key, img|
            image = key.tempfile
            image_name = key.original_filename
            image_type = key.content_type

            @url = uploadImageToS3(image, image_name, image_type)

            @img_path = ImagePath.new
            @img_path.branch_id = @branch.id
            if !@url.nil?
              @img_path.url = @url
            end
            @img_path.save
          end
        end
        
        if @al_paso == "1"
          @table = Table.new
          @table.description = "Mesa Predeterminada"
          @table.state = "Abierta"
          @table.number = 0
          @table.branch_id = @branch.id
          @table.save
        end
      
        format.html { redirect_to @branch, notice: 'Sucursal creada exitosamente' }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update

    respond_to do |format|
      if @branch.update(branch_params)
        if  params[:branch][:images].present?
          if @branch.image_paths.present?
            ImagePath.where(branch_id: @branch.id).destroy_all
          end
          @branch.images.each do |img|
            @img_path = ImagePath.new
            @img_path.branch_id = @branch.id
            @img_path.url = polymorphic_url(img)
            @img_path.save
          end
        end

        if @branch.tables.empty?
          if @branch.step == "1"
            @table = Table.new
            @table.description = "Mesa Predeterminada"
            @table.state = "Abierta"
            @table.number = 0
            @table.branch_id = @branch.id
            @table.save
          end
        end
        
        if params[:branch][:hour_op_mon].present? && params[:branch][:hour_cl_mon].present?
          @monday = Schedule.new
          @monday.day = params[:branch][:day_lun]
          @monday.opening = params[:branch][:hour_op_mon]
          @monday.closing = params[:branch][:hour_cl_mon]
          @monday.branch_id = @branch.id
          @monday.save
        end

        if params[:branch][:hour_op_tue].present? && params[:branch][:hour_cl_tue].present?
          @tuesday = Schedule.new
          @tuesday.day = params[:branch][:day_mar]
          @tuesday.opening = params[:branch][:hour_op_tue]
          @tuesday.closing = params[:branch][:hour_cl_tue]
          @tuesday.branch_id = @branch.id
          @tuesday.save
        end

        if params[:branch][:hour_op_wed].present? && params[:branch][:hour_cl_wed].present?
          @wednesday = Schedule.new
          @wednesday.day = params[:branch][:day_mie]
          @wednesday.opening = params[:branch][:hour_op_wed]
          @wednesday.closing = params[:branch][:hour_cl_wed]
          @wednesday.branch_id = @branch.id
          @wednesday.save
        end

        if params[:branch][:hour_op_thu].present? && params[:branch][:hour_cl_thu].present?
          @thursday = Schedule.new
          @thursday.day = params[:branch][:day_jue]
          @thursday.opening = params[:branch][:hour_op_thu]
          @thursday.closing = params[:branch][:hour_cl_thu]
          @thursday.branch_id = @branch.id
          @thursday.save
        end

        if params[:branch][:hour_op_fri].present? && params[:branch][:hour_cl_fri].present?
          @friday = Schedule.new
          @friday.day = params[:branch][:day_vie]
          @friday.opening = params[:branch][:hour_op_fri]
          @friday.closing = params[:branch][:hour_cl_fri]
          @friday.branch_id = @branch.id
          @friday.save
        end

        if params[:branch][:hour_op_sat].present? && params[:branch][:hour_cl_sat].present?
          @saturday = Schedule.new
          @saturday.day = params[:branch][:day_sab]
          @saturday.opening = params[:branch][:hour_op_sat]
          @saturday.closing = params[:branch][:hour_cl_sat]
          @saturday.branch_id = @branch.id
          @saturday.save
        end

        if params[:branch][:hour_op_sun].present? &&  params[:branch][:hour_cl_sun].present?
          @sunday = Schedule.new
          @sunday.day = params[:branch][:day_dom]
          @sunday.opening = params[:branch][:hour_op_sun]
          @sunday.closing = params[:branch][:hour_cl_sun]
          @sunday.branch_id = @branch.id
          @sunday.save
        end

        format.html { redirect_to @branch, notice: 'La sucursal se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to branches_url, notice: 'Branch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.require(:branch).permit(:name, :telephone, :street, :email_manager, :telephone_manager, :information, :hour_op, :hour_cl, :instagram_id, :instagram_api_token, :restaurant_id, :branch_category, :lat, :leng, :step, :by_tables, days:[])
    end
end
