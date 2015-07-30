class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in anrd redirect to the user's show page.
      log_in user
      flash[:success] = "Bentornato in GeekStore!"
      redirect_back_or user
    else
      # Create an error message.
      flash.now[:danger] = "Nome utente o password errati!"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
  
end
