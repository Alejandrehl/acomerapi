class RolesController < ApplicationController
  def index
    @user = User.all
    @role = Role.all
  end

  def show
  end

  def assignrole
    user = User.find(params[:user])
    role = Role.find(params[:role])

    if role.name == 'operations'
      user.add_role :operations
    elsif role.name == 'admin'
      user.add_role :admin
    end

  end

  def show
  end

  def update
  end


end
