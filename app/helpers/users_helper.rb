module UsersHelper
  def show_avatar
    if current_user.photo?
      image_tag current_user.photo, class: "avatar avatar-large"
    else
      cl_image_tag("avatar.png", class: "avatar avatar-large")
    end
  end

  def show_card_avatar(user)
    if user.photo?
      image_tag user.photo, class:"card-user avatar avatar-large"
    else
      cl_image_tag("avatar.png", class: "avatar avatar-large")
    end
  end
end
