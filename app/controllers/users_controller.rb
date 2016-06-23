class UsersController < ApplicationController
  after_action :verify_authorized

  def show
    authorize User.find(params[:id])
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    # if @user.teacher?
    #   if @user.update(teacher_params)
    #     redirect_to user_path
    #   else
    #     flash[:alert] = t('.flash_alert')
    #   end
    # else
    if @user.update(user_params)
      redirect_to user_path
    else
      flash[:alert] = t('.flash_alert')
      render :show
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :street, :city, :zipcode, :country, :phone, :gender, :birth_date, :photo, :photo_cache, :level, :address, :street_number, yoga_type: [])
  end

end
