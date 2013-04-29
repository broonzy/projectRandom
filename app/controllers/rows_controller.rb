class RowsController < ApplicationController
  # GET /rows
  # GET /rows.json
  def index
    @rows = Row.all
    @cart = current_cart

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rows }
    end
  end

  # GET /rows/1
  # GET /rows/1.json

  # just below is the original before inserting from p121 to stop wibble effect
=begin
  def show
    @row = Row.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @row }
    end
  end
=end

  def show
    begin
      @row = Row.find(params[:id])
      @cart = current_cart
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid row #{params[:id]}"
      redirect_to :controller => "grid", :action => 'index', notice: 'Invalid row'
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @row }
      end
    end
  end

  # GET /rows/new
  # GET /rows/new.json
  def new
    @row = Row.new
    @cart = current_cart

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @row }
    end
  end

  # GET /rows/1/edit
  def edit
    @row = Row.find(params[:id])
    @cart = current_cart
  end

  # POST /rows
  # POST /rows.json
  def create
    @row = Row.new(params[:row])
    @cart = current_cart

    respond_to do |format|
      if @row.save
        format.html { redirect_to @row, notice: 'Row was successfully created.' }
        format.json { render json: @row, status: :created, location: @row }
      else
        format.html { render action: "new" }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rows/1
  # PUT /rows/1.json
  def update
    @row = Row.find(params[:id])
    @cart = current_cart

    respond_to do |format|
      if @row.update_attributes(params[:row])
        format.html { redirect_to @row, notice: 'Row was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rows/1
  # DELETE /rows/1.json
  def destroy
    @row = current_row
    @row.destroy

    @cart = current_cart
    session[:row_id] = nil

    respond_to do |format|
      format.html { redirect_to grid_url,
      notice: 'Your row is currently empty' }
      format.json { head :no_content }
    end
  end

end