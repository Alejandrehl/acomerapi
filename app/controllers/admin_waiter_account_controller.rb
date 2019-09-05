class AdminWaiterAccountController < ApplicationController
  before_action :set_waiter, only: [:show]
    
  def form
    @branches = Array.new 
    @restaurants.each do |r|
      r.branches.each do |b|
        @branches.push(b)
      end 
    end
  end

  def waiterbranch
      @waiter_per_branches = AdminWaiterAccount.where(branch_id: params[:id])
      @waiters = Array.new
      @waiter_per_branches.each do |w|
        @user = User.find(w.id_waiter)
        @waiters.push(@user)
      end
  end

  def show
  end

  def create

    @userw = User.new
    @userw.email = params[:email]
    @userw.password = params[:password]
    @userw.name = params[:name]
    @userw.last_name = params[:last_name]
    @userw.rut = params[:rut]
    @userw.save
    @userw.add_role :waiter
    @userw.remove_role :admin

    if @userw.save

      @waiter = AdminWaiterAccount.new
      if current_user.has_role? :admin
        @waiter.id_admin = @user.id 
      elsif current_user.has_role? :branch_leader 
        @waiter.id_admin = @admin.id
      end
      @waiter.id_waiter = @userw.id
      @waiter.branch_id = params[:branch_id]
      @waiter.save
      
      if params[:table_id]

        @waitertable = WaiterTable.new
        @waitertable.user_id = @userw.id
        @waitertable.table_id = params[:table_id]
        @waitertable.save
        @table = Table.find(params[:table_id])
        @table.assign = true
        @table.save

      end
      redirect_to admin_waiters_path
    else
      redirect_to admin_waiters_path, alert: "Error"
    end
  end

  def delete

    @waiter = User.find(params[:id])
    @waiter.remove_role :waiter
    
    @tablewaiter = WaiterTable.where(user_id: @waiter.id)
    @tablewaiter.each do |detail|
      @table = Table.find(detail.table_id)
      @table.assign = false
      @table.save
    end
    @tablewaiter.delete_all
    @waiteraccount = AdminWaiterAccount.where(id_waiter: @waiter.id)
    @waiteraccount.delete_all

    redirect_to admin_waiters_url

  end

  def deletetable

    @waitertable = WaiterTable.find(params[:id])
    @table = Table.find(@waitertable.table_id)
    @waitertable.delete
    @table.assign = false
    @table.save

    redirect_to show_path(id: params[:waiter])

  end

  def asigntables

    @tables = params[:tables]
    @waiter = params[:waiter]

    @tables.split(",").each do |t|

      @waitertable = WaiterTable.new
      @waitertable.user_id = @waiter
      @waitertable.table_id = t
      @waitertable.save
      @table = Table.find(t)
      @table.assign = true
      @table.save

    end

    redirect_to show_path(id: @waiter)

  end

  private

    def set_waiter
      @waiter = User.find(params[:id])
    end



end
