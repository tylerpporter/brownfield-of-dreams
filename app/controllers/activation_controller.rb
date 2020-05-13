class ActivationController < ApplicationController
  def show
    @message = "Thank you! Your account has been activated."
  end

  def update
    User.update(params[:user_id], status: 'active')
    redirect_to '/activate'
  end
end