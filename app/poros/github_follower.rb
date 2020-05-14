class GithubFollower
  class << self
    attr_reader :followers, :following
    def create
      @followers = []
      @following = []
      followers = GithubService.follower('followers')
      following = GithubService.follower('following')
      followers.each { |follower| create_follower(follower, @followers) }
      following.each { |follow| create_follower(follow, @following) }
    end

    private

    def create_follower(follower, type)
      type << new(follower[:login],
                  follower[:html_url],
                  follower[:id])
    end
  end
  attr_reader :handle, :url, :uid

  def initialize(handle, url, uid)
    @handle = handle
    @url = url
    @uid = uid
  end

  def user?
    User.find_by(uid: uid)
  end

  def user_id
    user?.id if user?
  end
end
