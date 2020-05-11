class GithubFollower
  @followers = []
  @following = []
  class << self
    attr_reader :followers, :following
    def create
      followers = GithubService.follower('followers')
      following = GithubService.follower('following')
      followers.each { |follower| create_follower(follower, @followers) }
      following.each { |follow| create_follower(follow, @following) }
    end

    private

    def create_follower(follower, type)
      type << new(follower[:login],
                  follower[:html_url])
    end
  end
  attr_reader :handle, :url

  def initialize(handle, url)
    @handle = handle
    @url = url
  end
end
