class LessonMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.lesson_mailer.creation.subject
  #
  def creation_confirmation(lesson)
      @lesson = lesson
      mail(
        to:       @lesson.teacher.email,
        subject:  "Lesson #{@lesson.name} created!"
      )
    end
end
