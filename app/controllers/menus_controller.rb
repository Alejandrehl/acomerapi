class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:show]
  include ApplicationHelper
  # GET /menus
  # GET /menus.json
  def index
    if current_user.has_role? :admin
      @user = current_user
      @restaurants = @user.restaurants
      @menus = Array.new
      @restaurants.each do |r|
        r.branches.each do |b|
          b.menus.each do |m|
            @menus.push(m)
          end 
        end 
      end
    elsif current_user.has_role? :branch_leader
      @menus = Array.new
      @branch.each do |b|
        b.menus.each do |m|
          @menus.push(m)
        end 
      end 
    end
    
  end

  # GET /menus/1
  # GET /menus/1.json
  def show

  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
  @menu = Menu.new(menu_params)

    image = params[:menu][:img_url].tempfile
    image_name = params[:menu][:img_url].original_filename
    image_type = params[:menu][:img_url].content_type

    # Se asigna la respuesta del helper a una variable.
    @url = uploadImageToS3(image, image_name, image_type)

    # Se pregunta si la variable trae datos
    if !@url.nil?
      @menu.img_url = @url
    end

    respond_to do |format|
      if @menu.save
        format.html { redirect_to admin_menus_path, notice: 'Carta creada con éxito.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to admin_menus_path, notice: 'Carta actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to admin_menus_url, notice: 'Carta eliminada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :description, :branch_id, :img_url, category_ids:[])
    end
end
