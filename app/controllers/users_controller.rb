class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
  end

  def edit
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
