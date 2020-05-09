class GithubController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    token = response[:credentials][:token]
    uid = response[:uid]
    user_params = {token: token, uid: uid}
    current_user.update(user_params)
    redirect_to dashboard_path
  end
end
