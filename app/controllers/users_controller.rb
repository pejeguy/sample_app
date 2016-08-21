class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

  def new
    @user = User.new
    @titre = "S'inscrire"
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
	  sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
	 @titre = "S'inscrire"
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:nom, :email, :password,
                                   :password_confirmation)
    end
end