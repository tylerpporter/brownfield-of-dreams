class UserVideosController < ApplicationController
  def new; end

  def create
    current_user ? create_user_video : failure
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end

  def create_user_video
    user_video = UserVideo.new(user_video_params)
    if current_user.user_videos.find_by(video_id: user_video.video_id)
      flash[:error] = 'Already in your bookmarks'
    elsif user_video.save
      flash[:success] = 'Bookmark added to your dashboard!'
    end
    redirect_back(fallback_location: root_path)
  end

  def failure
    flash[:notice] = 'User must login to bookmark videos.'
    redirect_to login_path
  end
end
