class ActivationMailer < ApplicationMailer  
  def inform(user)
    @user = user
    @message = "To activate your account click link below"

    mail(to: user.email, subject: 'Account activation for Brownfield')
  end
end
