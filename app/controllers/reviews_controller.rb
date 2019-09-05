class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Array.new
    current_user.products.each do |product|
      if !product.reviews.blank?
        product.reviews.each do |review|
          @reviews.push(review)
        end
      end
    end 
  end
 
  # GET /reviews/1
  # GET /reviews/1.json

  def restaurant_reviews

    @user = current_user
    @restaurants = @user.restaurants
    @restaurant_reviews = Array.new
    @categories = Array.new


    @restaurants.each do |r|
      r.branches.each do |b|
        b.menus.each do |m|
          m.categories.each do |c|
            if @categories.include?(c)
              "nothing"
            else
              @categories.push(c)
            end
            @categories.each do |c|
              c.products.each do |pr|
                pr.reviews.each do |r|
                  @restaurant_reviews.push(r)
                end
              end  
            end 
          end 
        end 
      end 
    end

  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_name = User.find(@review.user_id).name

    respond_to do |format|
      if @review.save
  
        ## Notificación a Firebase
        # base_uri = 'https://acomer-notifications.firebaseio.com'
        # firebase = Firebase::Client.new(base_uri)
        # response = firebase.push("reviews", @review.id )
        # response.success? # => true
        # response.code # => 200
        # response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
        # response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
        
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fire_reviews
    reviews = Review.where(id: [params[:reviewIds]]) ## Se traen todas las reviews según los ids que llegan del front.
    productIds = reviews.pluck(:product_id) ## Creamos un array con los ids de productos.
    products = current_user.products.where(id: productIds) ## Buscamos todos los productos del usuario autenticado.
    productIds = products.pluck(:id) ## sobre escribimos la variable con los ids de los productos del usuario.
    reviews = reviews.where(product_id: productIds); ## Traemos solo las reviews del usuario autenticado basandonos en el id de sus productos.

    respond_to do |format|
      format.json { render :json => reviews } 
    end
  end

  def send_report
    @user = User.find(params[:id])
    @review = Review.find(params[:review_id])
    UserReportMailer.send_report_email(@user, @review).deliver
    redirect_to admin_index_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:stars, :commentary, :user_id, :product_id)
    end
end
