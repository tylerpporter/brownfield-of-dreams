class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if params[:playlist_id]
      create_with_playlist
    else
      tutorial = Tutorial.create(tutorial_params)
      tutorial.save ? success(tutorial) : failure(tutorial)
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(update_tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    Tutorial.destroy(params[:id])
    redirect_to admin_dashboard_path
  end

  private

  def create_with_playlist
    youtube = YoutubeService.new
    playlist = youtube.playlist(params[:playlist_id])
    tutorial = Tutorial.create(import_tutorial_params)
    playlist[:items].each { |vid| create_video(vid, tutorial) }
    paginate(youtube, tutorial)
    import_success(tutorial)
    redirect_to admin_dashboard_path
  end

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
    flash[:success] = "Successfully created tutorial"
    redirect_to tutorial_path(tutorial.id)
  end

  def failure(tutorial)
    flash[:error] = tutorial.errors.full_messages.to_sentence
    redirect_to new_admin_tutorial_path
  end

  def import_success(tutorial)
    flash[:success] =
      "Successfully created tutorial.
      #{view_context.link_to 'View it here', tutorial_path(tutorial.id)}."
      .html_safe
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def update_tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def import_tutorial_params
    params.permit(:title, :description, :thumbnail, :playlist_id)
  end
end
