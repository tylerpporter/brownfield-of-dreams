class ActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    @message = 'To activate your account click link below'

    mail(to: user.email, subject: 'Account activation for Brownfield')
  end

  def invite(github_user, user)
    @github_user = github_user
    @message = EmailInvite.new(github_user, user).message

    mail(to: github_user[:email], subject: 'Invite to Brownfield')
  end
end
