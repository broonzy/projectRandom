class SessionsController < ApplicationController
  def create
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row

    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to :controller => "users", :action => "welcome", :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end

  def new
    @shapes = Shape.all
    @cart = current_cart
    @row = current_row
  end
end

