class OrdersController < ApplicationController

  skip_before_filter :authorize, only: [:new, :create]
  # GET /orders
  # GET /orders.json
  def index
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row
    @orders = Order.paginate page: params[:page], order: ' created_at desc',
                             per_page: 8

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row
    begin
    @order = Order.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid order #{params[:id]}"
      redirect_to :controller => "grid", :action => 'index', notice: 'Invalid action'
    else

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row

    if @cart.cart_line_items.empty?
      redirect_to :controller => "grid", :action => "index" , notice: 'your cart is empty'
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  #def authorize from cart controller
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  # GET /orders/1/edit
  def edit
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row
    @order = Order.find(params[:id])

  end

  # POST /orders
  # POST /orders.json
  def create
    @cart = current_cart
    @row = current_row
    @order = current_user.orders.new(params[:order])

    @order.add_cart_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to :controller => "grid", :action => "thanks", notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
