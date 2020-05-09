class GithubController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    token = response[:credentials][:token]
    uid = response[:uid]
    user_params = {token: token, uid: uid}
    current_user.update(user_params)
    require "pry"; binding.pry
    redirect_to dashboard_path
  end
end
