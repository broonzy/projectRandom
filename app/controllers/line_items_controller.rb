class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
    @row = current_row
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])
    @row = current_row
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new
    @row = current_row
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
    @row = current_row
  end

  # POST /line_items
  # POST /line_items.json
  def create
    #@line_item = LineItem.new(params[:line_item])
    @row = current_row
    @cart = current_cart
    shape = Shape.find(params[:shape_id])
    @line_item = @row.line_items.build
    @line_item.shape = shape
    #below from movies. necessary?
    #@line_item = @row.add_shape(shape.id)

    respond_to do |format|
      if @line_item.save
        #changing the below line to grid_url is causing routing error- action 'destroy' could not be found
        #for rows controller
        #format.html { redirect_to @line_item.row }
        format.html { redirect_to grid_url }

        #next line is for animate fade effect
        format.js   #{ @current_item = @line_item }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])
    @row = current_row

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    @row = current_row

     #below from http://pragprog.com/wikis/wiki/Pt-E-4
    #if @line_item.quantity > 6
      #@row.destroy
    #end


    #if @line_item.quantity > 6
      #Row.destroy(session[:row_id])
      #session[:row_id] = nil
    #end

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end
end
