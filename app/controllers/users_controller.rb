class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :authorize_admin_or_owner, only: %i[edit update]

  def index
    @users = User.all
  end

  def edit; end

  def update
    if @user.update(update_params)
      redirect_to users_path, notice: 'User updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin_or_owner
    # user can edit self
    # admin can edit anybody
    redirect_to users_path, alert: 'You are not authorized' unless @user == current_user || current_user.admin?
  end

  def update_params
    # params.require(:user).permit(:name, :role)

    # return params.require(:user).permit(:name) if @user == current_user
    # return params.require(:user).permit(:name, :role) if current_user.admin?

    allowed_params = []
    allowed_params += [:name] if @user == current_user
    allowed_params += [:role] if current_user.admin?
    params.require(:user).permit(allowed_params)
  end
end
