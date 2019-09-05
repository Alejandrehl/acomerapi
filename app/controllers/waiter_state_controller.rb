class WaiterStateController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
      @waiterstate = WaiterState.all
  end

  def create
      @waiterstate = WaiterState.new
      @waiterstate.reason = params[:reason]
      @waiterstate.table_id = params[:table_id]
  
      respond_to do |format|
        if @waiterstate.save
          @table = Table.find(params[:table_id])
          table_user_id = @table.user.ids[0]
          ActionCable.server.broadcast 'calltowaiter_channel',
          id: @waiterstate.id,
          reason: @waiterstate.reason,
          table_id: @waiterstate.table_id,
          table_user_id: table_user_id
          format.json { render :json => {:waitercall => @waiterstate } and return }
        else
          format.json { render json: @waiterstate.errors.full_message, status: :unprocessable_entity }
        end
      end
  end
end
