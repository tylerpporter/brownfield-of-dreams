class PlaylistVideo 
  def initialize(video_id)
    @video_id = video_id[:contentDetails][:videoId]
    youtube = YoutubeService.new
    @info = youtube.video_info(@video_id)
  end

  def title
    @info[:items].first[:snippet][:title]
  end

  def description
    @info[:items].first[:snippet][:description]
  end

  def thumbnail
    @info[:items][0][:snippet][:thumbnails][:default][:url]
  end

  def id
    @video_id
  end
end