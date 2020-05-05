class UsersController < ApplicationController
  def show
    conn = Faraday.new('https://api.github.com') do |req|
      req.headers[:Authorization] = "token #{ENV['GITHUB_TOKEN']}"
    end
    resp = conn.get('/user/repos')
    @repos = JSON.parse(resp.body, symbolize_names: true)[0..4]
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
