class SingularBranchController < ApplicationController
  include ApplicationHelper
    def index
    end

    def create
        @restaurant = Restaurant.new
        @restaurant.name = params[:name]
        @restaurant.description = params[:description]
        @restaurant.business_name = params[:business_name]
        @restaurant.giro = params[:giro]
        @restaurant.telephone = params[:telephone]
        @restaurant.email = params[:email]
        @restaurant.instagram = params[:instagram]
        @restaurant.facebook = params[:facebook]
        @restaurant.twitter = params[:twitter]
        @restaurant.pinterest = params[:pinterest]
        @restaurant.tripadvisor = params[:tripadvisor]
        @restaurant.user_id = params[:user_id]

        image = params[:logo_url].tempfile
        image_name = params[:logo_url].original_filename
        image_type = params[:logo_url].content_type
      
        # Se asigna la respuesta del helper a una variable.
        @url = uploadImageToS3(image, image_name, image_type)
      
        # Se pregunta si la variable trae datos
        if !@url.nil?
          @restaurant.image = @url
        end
        @restaurant.save


        @branch = Branch.new
        @branch.name = params[:name]
        @branch.telephone = params[:telephone]
        @branch.street = params[:street]
        @branch.email_manager = params[:email_manager]
        @branch.telephone_manager = params[:telephone_manager]
        @branch.information = params[:description]
        @branch.lat = params[:branch][:lat]
        @branch.leng = params[:branch][:leng]
        @branch.by_tables = params[:by_tables]
        @branch.step = params[:step]
        @branch.branch_category = params[:branch_category]
        @branch.instagram_id = params[:instagram_id_branch]
        @branch.instagram_api_token = params[:instagram_api_token_branch]
        @branch.restaurant_id = @restaurant.id
    
        respond_to do |format|
            if @branch.save
              if params[:hour_op_mon].present? && params[:hour_cl_mon].present?
                @monday = Schedule.new
                @monday.day = params[:day_lun]
                @monday.opening = params[:hour_op_mon]
                @monday.closing = params[:hour_cl_mon]
                @monday.branch_id = @branch.id
                @monday.save
              end
      
              if params[:hour_op_tue].present? && params[:hour_cl_tue].present?
                @tuesday = Schedule.new
                @tuesday.day = params[:day_mar]
                @tuesday.opening = params[:hour_op_tue]
                @tuesday.closing = params[:hour_cl_tue]
                @tuesday.branch_id = @branch.id
                @tuesday.save
              end
      
              if params[:hour_op_wed].present? && params[:hour_cl_wed].present?
                @wednesday = Schedule.new
                @wednesday.day = params[:day_mie]
                @wednesday.opening = params[:hour_op_wed]
                @wednesday.closing = params[:hour_cl_wed]
                @wednesday.branch_id = @branch.id
                @wednesday.save
              end
      
              if params[:hour_op_thu].present? && params[:hour_cl_thu].present?
                @thursday = Schedule.new
                @thursday.day = params[:branch][:day_jue]
                @thursday.opening = params[:hour_op_thu]
                @thursday.closing = params[:hour_cl_thu]
                @thursday.branch_id = @branch.id
                @thursday.save
              end
      
              if params[:hour_op_fri].present? && params[:hour_cl_fri].present?
                @friday = Schedule.new
                @friday.day = params[:day_vie]
                @friday.opening = params[:hour_op_fri]
                @friday.closing = params[:hour_cl_fri]
                @friday.branch_id = @branch.id
                @friday.save
              end
      
              if params[:hour_op_sat].present? && params[:hour_cl_sat].present?
                @saturday = Schedule.new
                @saturday.day = params[:day_sab]
                @saturday.opening = params[:hour_op_sat]
                @saturday.closing = params[:hour_cl_sat]
                @saturday.branch_id = @branch.id
                @saturday.save
              end
      
              if params[:hour_op_sun].present? &&  params[:hour_cl_sun].present?
                @sunday = Schedule.new
                @sunday.day = params[:day_dom]
                @sunday.opening = params[:hour_op_sun]
                @sunday.closing = params[:hour_cl_sun]
                @sunday.branch_id = @branch.id
                @sunday.save
              end

              @al_paso = @branch.step

              if params[:img_url].present?
                params[:img_url].each do |key, img|
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

                format.html { redirect_to admin_index_path, notice: 'Sucursal creada con éxito.' }
                format.json { render :show, status: :created, location: @branch }
            else
                format.html { render :new }
                format.json { render json: @branch.errors, status: :unprocessable_entity }
            end
        end
    end

end
