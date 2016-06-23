class TeachersController < ApplicationController
  after_action :verify_authorized

  def show
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    @message = current_user.messages.new
    authorize @message
  end

  def new
    @teacher = current_user.becomes(Teacher)
    authorize @teacher
  end

  def update
    @teacher = User.find(params[:id]).becomes(Teacher)
    authorize @teacher
    if @teacher.update(teacher_params)
      @teacher.set_as_teacher
      redirect_to user_path(@teacher)
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  def lessons
    @lessons = Teacher.find(params[:id]).lessons
    if @lessons == []
      authorize Teacher.find(params[:id]).lessons.new
    else
      @lessons.each { |i| authorize i, :my_index? }
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :password, :email, :street, :city, :zipcode, :country, :phone, :gender, :birth_date, :photo, :photo_cache, :yoga_type, :level, :address, :street_number, :experience, :description, photos: [])
  end

end
