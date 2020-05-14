class UsersController < ApplicationController
  def show
    @tutorials = Tutorial.joins(videos: [:user_videos]).distinct
    GithubService.token = current_user.token
    @github = GithubDashboard.create unless current_user.token.nil?
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name}"
      ActivationMailer.inform(user).deliver_now
      redirect_to dashboard_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
