class SessionsController < ApplicationController
  
  # show new session template (login page)
  def new
  end
  
  # create a new session instance from username and password
  def create
    user = User.find_by(name: params[:session][:name].downcase)
    # use the rails authenticate helper to check credentials
    if user && user.authenticate(params[:session][:password])
      # log the user in and redirect to the user's show page.
      log_in user
      flash[:success] = "Bentornato in GeekStore!"
      redirect_back_or user
    else
      flash.now[:danger] = "Nome utente o password errati!"
      # redirect to login page
      render 'new'
    end
  end

  # logout the current user
  def destroy
    log_out if logged_in?
    # redirect to home page
    redirect_to root_path
  end
  
end
