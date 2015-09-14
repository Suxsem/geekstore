class UsersController < ApplicationController
  
  # ensure that only a logged user can operate on a user profile
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  # ensure that a user can operate only on his own profile
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  # prevent unauthorized access from non-admin users
  before_action :logged_in_admin, only: [:index]

  # retrieve all users (admin only)
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # retrieve the current user
  def show
    @user = User.find(params[:id])
  end
  
  # create a new user
  def new
    @user = User.new
  end
  
  # validate and save a new user
  def create
    @user = User.new(user_params)
    if @user.save
      # automatically log the user after signup
      log_in @user
      flash[:success] = "Benvenuto in GeekStore!"
      # redirect to user profile
      redirect_to @user
    else
      # if validataion fails redirect to the signup page
      render 'new'
    end
  end
  
  # retrieve a single user to be edited
  def edit
    @user = User.find(params[:id])
  end
  
  # validate and update an existing user
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Informazioni modificate con successo"
      # if the user was edited by an admin, redirect to the all users page
      # =>  otherwise redirect to the user profile pageile page
      redirect_to admin? ? users_path : @user
    else
      # if validataion fails redirect to profile edit form
      render 'edit'
    end
  end
  
  # destroy a single user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Cliente rimosso"
      # if the user was destroyed by an admin, redirect to the all users page
      # =>  otherwise redirect to the home page
    redirect_to admin? ? users_path : root_path
  end
  
  private

    # allow only authorized request parameters for user
    def user_params
      params.require(:user).permit(:name, :password,
                                   :password_confirmation)
    end
    
    # Before filters

    # confirms the correct user.
    def correct_user
      # return true also if the user is an admin
      return true if admin?
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "Non sei autorizzato a visitare questa pagina"
        # if a user is trying to operate on another user's profile, redirect to the home page
        redirect_to root_path
      end
    end
    
end
