class WaiterCallController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @waitercall = WaiterCall.all
    end

    def create
        @waitercall = WaiterCall.new
        @waitercall.table_id = params[:table_id]

        respond_to do |format|
          if @waitercall.save
            ActionCable.server.broadcast 'calltowaiter_channel',
            id: @waitercall.id,
            table_id: @waitercall.table_id
            format.json { render :json => {:waitercall => @waitercall } and return }
          else
            format.json { render json: @waitercall.errors.full_message, status: :unprocessable_entity }
          end
        end
    end

end
