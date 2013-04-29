class UsersController < ApplicationController
  #before_filter :is_admin?

  def index
    #@users = User.(:all)
    # below is depricated?

    #@users = User.find(:all)
    @users = User.all
    @cart = current_cart
    @row = current_row

  end

  def new
    @user = User.new
    @cart = current_cart
    @row = current_row
    @shapes = Shape.all
  end

   # welcome is from movies
  def welcome
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row

    #@orders = Order.paginate page: params[:page], order: ' created_at desc',
        #per_page: 3

    @history = Order.paginate(:per_page => 3,
                              :page => params[:page],
                              :order => 'created_at DESC').where(user_id:current_user[:id])

    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end



  #def edit added from agile
  def edit
    @user = User.find(params[:id])
    @shapes = Shape.where(wanted: 'yes')
    @cart = current_cart
    @row = current_row
  end

  #def show added from agile
  def show
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row

    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid user #{params[:id]}"
      redirect_to :controller => "grid", :action => 'index', notice: 'Invalid action'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def create
    @user = User.new(params[:user])
    @cart = current_cart
    @row = current_row
    @shapes = Shape.all

    if @user.save
      redirect_to login_path, :notice => 'User creation successful!'
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Details were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
