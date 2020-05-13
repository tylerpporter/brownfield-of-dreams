class InvitesController < ApplicationController
  def new; end

  def create
    github_user = GithubService.get_user(params[:github_handle])
    github_user[:email] ? send_invite(github_user) : failure
    redirect_to dashboard_path
  end

  private

  def send_invite(github_user)
    ActivationMailer.invite(github_user, current_user).deliver_now
    flash[:success] = "Successfully sent invite!"
  end

  def failure
    flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
  end

end
