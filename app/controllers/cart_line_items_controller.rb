class CartLineItemsController < ApplicationController
  # GET /cart_line_items
  # GET /cart_line_items.json
  def index
    @cart_line_items = CartLineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cart_line_items }
    end
  end

  # GET /cart_line_items/1
  # GET /cart_line_items/1.json
  def show
    @cart_line_item = CartLineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart_line_item }
    end
  end

  # GET /cart_line_items/new
  # GET /cart_line_items/new.json
  def new
    @cart_line_item = CartLineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart_line_item }
    end
  end

  # GET /cart_line_items/1/edit
  def edit
    @cart_line_item = CartLineItem.find(params[:id])
  end

  # POST /cart_line_items
  # POST /cart_line_items.json
  def create
    #below line commented out just because it's not in agile p110
    #@cart_line_item = CartLineItem.new(params[:cart_line_item])
    @cart = current_cart
    @row = current_row
    shape = Shape.find(params[:shape_id])
    #below line replaced by the following from p116
    #@cart_line_item = @cart.cart_line_items.build
    @cart_line_item = @cart.add_shape(shape.id)
    #why the below line cannot find shape?  is it needed?
    @cart_line_item.shape = shape

    respond_to do |format|
      if @cart_line_item.save
        format.html { redirect_to @cart_line_item.cart}
        format.js   { @current_item = @cart_line_item }
        format.json { render json: @cart_line_item,
                             status: :created, location: @cart_line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @cart_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cart_line_items/1
  # PUT /cart_line_items/1.json
  def update
    @cart_line_item = CartLineItem.find(params[:id])

    respond_to do |format|
      if @cart_line_item.update_attributes(params[:cart_line_item])
        format.html { redirect_to @cart_line_item, notice: 'Cart line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_line_items/1
  # DELETE /cart_line_items/1.json
  def destroy
    @cart_line_item = CartLineItem.find(params[:id])
    @cart_line_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_line_items_url }
      format.json { head :no_content }
    end
  end
end
