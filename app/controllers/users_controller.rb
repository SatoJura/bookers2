class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
  end

  def create
    user.save
    flash[:notice]="Welcome! You have signed up successfully."
  end

  def edit
    @user = current_user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction,)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
	  unless @user == current_user
		redirect_to user_path(current_user)
	  end
	end
end
