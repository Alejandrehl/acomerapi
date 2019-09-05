class UserController < ApplicationController
  def getUser
    user = User.find(params[:user_id])
    respond_to do |format|
      format.json { render :json => user } 
    end
  end
end
