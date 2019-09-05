class AdminCookAccountsController < ApplicationController
  before_action :set_cook, only: [:show]

  # GET /admin_cook_accounts/1
  # GET /admin_cook_accounts/1.json
  def show
  end

  def cookbranch
    @cook_per_branches = AdminCookAccount.where(branch_id: params[:id])
    @cooks = Array.new
    @cook_per_branches.each do |c|
      @user = User.find(c.id_cook)
      @cooks.push(@user)
    end
end

  # GET /admin_cook_accounts/new
  def form
    @branches = Array.new 
    @restaurants.each do |r|
      r.branches.each do |b|
        @branches.push(b)
      end 
    end
  end

  # POST /admin_cook_accounts
  # POST /admin_cook_accounts.json
  def create
    @userc = User.new
    @userc.email = params[:email]
    @userc.password = params[:password]
    @userc.name = params[:name]
    @userc.last_name = params[:last_name]
    @userc.rut = params[:rut]
    @userc.save
    @userc.add_role :cook
    @userc.remove_role :admin

    if @userc.save
      @admin_cook_account = AdminCookAccount.new
      if current_user.has_role? :admin
        @admin_cook_account.id_admin = @user.id
      elsif current_user.has_role? :branch_leader
        @admin_cook_account.id_admin = @admin.id
      end
      @admin_cook_account.id_cook = @userc.id
      @admin_cook_account.branch_id = params[:branch_id]
      @admin_cook_account.save
      redirect_to admin_cooks_path
    else
      redirect_to admin_cooks_path, alert: "Error"
    end
  
  end

  # DELETE /admin_cook_accounts/1
  # DELETE /admin_cook_accounts/1.json
  def delete

    @cook = User.find(params[:id])
    @cook.remove_role :waiter
    
    @cookaccounts = AdminCookAccount.where(id_cook: @cook.id)
    @cookaccounts.delete_all

    redirect_to admin_cooks_url

  end

  private
    
    def set_cook
      @cook = User.find(params[:id])
    end

end
