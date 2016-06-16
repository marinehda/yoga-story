class TeachersController < ApplicationController
  #before_action :set_teacher, only: [:update]
  after_action :verify_authorized

#   def index
#     @teachers = policy_scope(Teacher)
#   end
#
#   def show
#     authorize Teacher.find(params[:id])
#     @teacher = current_user
#   end
#

  def new
    @teacher = current_user.becomes(Teacher)
    authorize @teacher
  end

  # def create
  #   @teacher = User.find(params[:id]).set_as_teacher
  #   if @teacher.save
  #     # TO uncomment after mailer creation:
  #     # TeacherMailer.creation_confirmation(@teacher, @user).deliver_now
  #     redirect_to user_path(@teacher)
  #   else
  #     flash[:alert] = t('.flash_alert')
  #   end
  # end
#
  # def edit
  #   @teacher = User.find(params[:id])
  #   authorize @teacher
  # end
#
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
#
#   private
#
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :password, :email, :street, :city, :zipcode, :country, :phone, :gender, :birth_date, :photo, :photo_cache, :yoga_type, :level, :address, :street_number, :experience, :description, photos: [])
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

end
