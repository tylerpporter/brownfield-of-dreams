class InvitesController < ApplicationController
  def new; end

  def create
    github_user = GithubService.get_user(params[:github_handle])
    if github_user[:email]
      ActivationMailer.invite(github_user, current_user).deliver_now
      flash[:success] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

end
