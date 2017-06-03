class Admin::UsersController < Admin::BaseController

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    flash.notice = "This user has now been edited"

    redirect_to admin_user_path(@user)
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :address, :city, :state, :zipcode, :role)
  end

end
