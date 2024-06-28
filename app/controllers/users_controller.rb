class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      update_roles(@user)
      redirect_to root_path, notice: "Profile updated successfully"
    else
      render :edit
    end
  end

  def correct_user
     @user = User.find(params[:id])
     unless @user == current_user
       flash[:alert] = "You are not authorized to edit this profile"
       redirect_to(root_path)
     end
   end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_roles(user)
    if params[:user][:role] == 'seller'
      user.create_seller unless user.seller?
    else
      user.seller&.destroy
    end

    if params[:user][:role] == 'buyer'
      user.create_buyer unless user.buyer?
    else
      user.buyer&.destroy
    end
  end
end
