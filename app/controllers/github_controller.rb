class GithubController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    params = {
      token: response[:credentials][:token],
      uid: response[:uid].to_i,
      username: response[:info][:nickname]
    }
    current_user.update_columns(params)
    redirect_to dashboard_path
  end
end
