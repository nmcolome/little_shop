class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :update]

  def show
  end

  def update
    @user.update(user_params)
    flash.notice = "This user has now been edited"
    redirect_to admin_user_path(@user)
  end

private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :address, :city, :state, :zipcode, :role)
  end

end
