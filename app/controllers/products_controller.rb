class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:show]
  require "tinify"
  Tinify.key = "a8GxwKPC6ZGRuqfwPLALbLZHmf9P3X16"
  include ApplicationHelper

  # GET /products
  # GET /products.json
  def index
    @products = current_user.products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @reviews = @product.reviews
    # PRODUCT SCORE:
    if !@reviews.blank?
      @product_score = @reviews.pluck(:stars).sum / @reviews.size.to_f
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    respond_to do |format|
      if @product.save
        if params[:product][:img_url].present?
          params[:product][:img_url].each do |key, img|
            image = key.tempfile
            image_name = key.original_filename
            image_type = key.content_type

            @url = uploadImageToS3(image, image_name, image_type)

            @img_path = ImageProductPath.new
            @img_path.product_id = @product.id
            if !@url.nil?
              @img_path.url = @url
            end
            @img_path.save
          end
        end
        if params[:product][:category_id] != nil
          @product.assign_category(Category.find(params[:product][:category_id]))
          format.html { redirect_to categories_show_products_path(Category.find(params[:product][:category_id])), notice: 'Producto creado con exito.' }
        end
        format.html { redirect_to admin_products_path, notice: 'Producto creado con exito.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: 'Product eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  def assign_category
    product = Product.find(params[:product_id])
    category = Category.find(params[:category_id])
    if product.assign_category(category)
      redirect_to product_path(product), notice: 'Categoría correctamente asignada.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      if params[:_method] == "patch"
        params.permit(:name, :description, :price, :cost, :ingredient, :calories, :proteins, :carbohydrates, :saturated_fats, :unsaturated_fats, :vegan, :vegetarian, :specialty, :activated, :value_offer, :waiting_time, :user_id, :offer_activated, category_ids:[] ,images:[])
      else
        params.require(:product).permit(:name, :description, :price, :cost, :ingredient, :calories, :proteins, :carbohydrates, :saturated_fats, :unsaturated_fats, :vegan, :vegetarian, :specialty, :activated, :value_offer, :waiting_time, :user_id, :offer_activated, category_ids:[] ,images:[])
      end
    end
end
