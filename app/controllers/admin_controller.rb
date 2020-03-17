class AdminController < ApplicationController
  before_action :ensure_admin

  def delete_user
    @user = User.find(params[:user])
    @user.destroy if @user

    redirect_to volunteers_path
  end
end
