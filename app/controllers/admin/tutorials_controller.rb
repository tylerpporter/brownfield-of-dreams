class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    youtube = YoutubeService.new
    playlist = youtube.playlist(params[:playlist_id])
    tutorial = Tutorial.create(import_tutorial_params)
    playlist[:items].each do |video|
      id = video[:contentDetails][:videoId]
      info = youtube.video_info(id)
      title = info[:items].first[:snippet][:title]
      description = info[:items].first[:snippet][:description]
      thumbnail = YouTube::Video.by_id(id).thumbnail
      new_video_params = {title: title, description: description, video_id: id, thumbnail: thumbnail}
      video = tutorial.videos.create(new_video_params)
    end
    flash[:success] = "Successfully created tutorial. #{view_context.link_to 'View it here', tutorial_path(tutorial.id)}.".html_safe
    redirect_to admin_dashboard_path
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def import_tutorial_params
    params.permit(:title, :desciption, :thumbnail, :playlist_id)
  end
end
