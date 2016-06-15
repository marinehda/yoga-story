class TeachersController < ApplicationController
  before_action :set_teacher, only: [:edit, :show]
  after_action :verify_authorized

  def index
    @teachers = policy_scope(Teacher)
  end

  def show
  end

  def new
    @teacher = Teacher.new
    authorize @teacher
  end

  def create
    @user = current_user
    @teacher = current_user.teacher.build(boat_params)
    @teacher.user_id = current_user.id if current_user
    if @teacher.save
      flash[:notice] = "Your teacher profile was successfully created"
      # TO uncomment after mailer creation:
      # TeacherMailer.creation_confirmation(@teacher, @user).deliver_now
      redirect_to teacher
    else
      flash[:alert] = "Your teacher profile was not created!"
    end
  end

  def edit
  end

  def update
    teacher = current_user.teacher.find(params[:id])
    if teacher.update!(teacher_params)
      redirect_to teacher
    else
      flash[:alert] = "Your profile was not updated!"
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:experience, :description)
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

end
