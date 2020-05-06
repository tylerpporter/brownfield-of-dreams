require_relative 'github_repo'
require_relative 'github_follower'

class UserDashboard
  attr_reader :repos, :followers, :following

  def initialize
    @repos = GithubRepo.all
    @followers = GithubFollower.followers
    @following = GithubFollower.following
  end

  def self.create
    GithubRepo.create
    GithubFollower.create
    UserDashboard.new
  end
end
