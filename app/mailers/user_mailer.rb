class UserMailer < ApplicationMailer
    def send_notice_mail(user, title, content)
        @user = user
        @content = content
        mail to: user.email, subject: title
    end
end
