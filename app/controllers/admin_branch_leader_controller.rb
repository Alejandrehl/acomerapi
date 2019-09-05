class AdminBranchLeaderController < ApplicationController
  before_action :set_leader, only: [:show]

  # GET /admin_cook_accounts/1
  # GET /admin_cook_accounts/1.json
  def show
  end

  def leaderbranch
    @leader_per_branches = AdminBranchLeader.where(branch_id: params[:id])
    @leaders = Array.new
    @leader_per_branches.each do |l|
      @user = User.find(l.id_leader)
      @leaders.push(@user)
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
    @waiters = Array.new
    @waiters_per_branches = AdminWaiterAccount.where(id_admin: @user)
    @waiters_per_branches.each do |w|
      @users = User.find(w.id_waiter)
      @waiters.push(@users)
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
    @userc.add_role :branch_leader
    @userc.remove_role :admin

    if @userc.save
      @admin_branch_leader = AdminBranchLeader.new
      @admin_branch_leader.id_admin = @user.id
      @admin_branch_leader.id_leader = @userc.id
      @admin_branch_leader.branch_id = params[:branch_id]
      @admin_branch_leader.save
      redirect_to admin_leaders_path
    else
      redirect_to admin_leaders_path, alert: "Error"
    end

  
  end

  # DELETE /admin_cook_accounts/1
  # DELETE /admin_cook_accounts/1.json
  def delete

    @leader = User.find(params[:id])
    @leader.remove_role :branch_leader

    @waiters_per_branches = AdminBranchLeader.where(id_leader: @leader.id)
    @waiters_per_branches.delete_all

    redirect_to admin_leaders_path

  end

  private
    
    def set_leader
      @leader = User.find(params[:id])
    end

end
