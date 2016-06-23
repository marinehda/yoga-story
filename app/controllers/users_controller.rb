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
    if params[:user][:birth_date] != "" && @user.update(user_params)
      # @user.update(user_params)
      redirect_to user_path
    else
      flash[:alert] = t('.flash_alert')
      render :edit
    end
  end

private

  def user_params
    parameters = params.require(:user).permit(:first_name, :last_name, :password, :email, :street, :city, :zipcode, :country, :phone, :gender, :birth_date, :photo, :photo_cache, :level, :address, :street_number, yoga_type: [])
    parameters[:birth_date] =  Date.strptime(parameters[:birth_date], "%d/%m/%Y")
    parameters
  end

end
