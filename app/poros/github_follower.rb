require_relative 'connectable'

class GithubFollower
  extend Connectable
  @followers = []
  @following = []
  class << self
    attr_reader :followers, :following

    def create(current_user)
      conn = Connectable.conn('https://api.github.com', current_user)
      followers = JSON.parse(conn.get('/user/followers')
                      .body, symbolize_names: true)
      following = JSON.parse(conn.get('/user/following')
                      .body, symbolize_names: true)
      followers.each { |follower| create_follower(follower, @followers) }
      following.each { |follow| create_follower(follow, @following) }
    end

    private

    def create_follower(follower, type)
      type << GithubFollower.new(follower[:login],
                                 follower[:html_url])
    end
  end
  attr_reader :handle, :url

  def initialize(handle, url)
    @handle = handle
    @url = url
  end
end
