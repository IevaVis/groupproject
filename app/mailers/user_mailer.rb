class UserMailer < ActionMailer::Base

	default from: "pairbnbproject@gmail.com"

	def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to GroupProject")
  end
end

	
