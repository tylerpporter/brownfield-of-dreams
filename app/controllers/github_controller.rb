class GithubController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    params = {
      token: response[:credentials][:token],
      uid: response[:uid].to_i,
      github_handle: response[:info][:nickname]
    }
    current_user.update(params)
    redirect_to dashboard_path
  end
end
