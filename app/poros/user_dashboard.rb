require_relative 'github_repo'
require_relative 'github_follower'

class UserDashboard
  attr_reader :repos, :followers, :following

  def initialize
    @repos = GithubRepo.all
    @followers = GithubFollower.followers
    @following = GithubFollower.following
  end

  def self.create(current_user)
    GithubRepo.create(current_user)
    GithubFollower.create(current_user)
    UserDashboard.new
  end
end
