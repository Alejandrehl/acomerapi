class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:show]

  include ApplicationHelper

  # GET /ies
  # GET /ies.json
  def index
    if current_user.has_role? :admin
      @categories = current_user.categories
    end
  end

  # GET /ies/1
  # GET /ies/1.json
  def show
  end

  # GET /ies/new
  def new
    @category = Category.new
  end

  # GET /ies/1/edit
  def edit
  end

  # POST /ies
  # POST /ies.json
  def create
    @category = Category.new(category_params)

    # myBucket = 'isaprespdf-informacionisapres-repository.s3.amazonaws.com'
    image = params[:category][:img_url].tempfile
    image_name = params[:category][:img_url].original_filename
    image_type = params[:category][:img_url].content_type

    # Se asigna la respuesta del helper a una variable.
    @url = uploadImageToS3(image, image_name, image_type)

    # Se pregunta si la variable trae datos
    if !@url.nil?
      @category.img_url = @url
    end

    respond_to do |format|
      if @category.save
        if params[:category][:image].present?
          @img_path = ImagePathCategory.new
          @img_path.category_id = @category.id
          if !@url.nil?
            @img_path.url = @url
          end
          @img_path.save
        end
        format.html { redirect_to admin_categories_path, notice: 'Categoría creada con éxito.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ies/1
  # PATCH/PUT /ies/1.json
  def update
    respond_to do |format|
      if @category.image.attached?
        @category.img_url = url_for(@category.image)
      end
      if params[:category][:image].present?
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
      if @category.update(category_params)
        format.html { redirect_to admin_categories_path, notice: 'Categoría actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ies/1
  # DELETE /ies/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Categoría eliminada con éxito' }
      format.json { head :no_content }
    end
  end

  def show_products
    # if !current_user.categories.pluck(:id).include?params[:id].to_i
    #   redirect_to root_path
    # end
    if params[:format]
      @category = Category.find(params[:format])
    else
      @category = Category.find(params[:id])
    end
    @products = @category.products
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description, :user_id, :img_url, product_ids:[])
    end
end
