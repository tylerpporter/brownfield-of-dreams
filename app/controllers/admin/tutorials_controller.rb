class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    youtube = YoutubeService.new
    playlist = youtube.playlist(params[:playlist_id])
    tutorial = Tutorial.create(import_tutorial_params)
    playlist[:items].each { |vid| create_video(vid, tutorial) }
    paginate(youtube, tutorial)
    success(tutorial)
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
    Tutorial.destroy(params[:id])
    redirect_to admin_dashboard_path
  end

  private

  def paginate(youtube, tutorial)
    loop do
      playlist = youtube.next_page(params[:playlist_id])
      playlist[:items].each do |video|
        create_video(video, tutorial)
      end
      break if playlist[:nextPageToken].nil?
    end
  end

  def create_video(video, tutorial)
    vid = PlaylistVideo.new(video)
    new_video_params = {
      title: vid.title,
      description: vid.description,
      video_id: vid.id,
      thumbnail: vid.thumbnail
    }
    tutorial.videos.create(new_video_params)
  end

  def success(tutorial)
    flash[:success] =
      "Successfully created tutorial.
      #{view_context.link_to 'View it here', tutorial_path(tutorial.id)}."
      .html_safe
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def import_tutorial_params
    params.permit(:title, :desciption, :thumbnail, :playlist_id)
  end
end
