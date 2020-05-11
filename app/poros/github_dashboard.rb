class GithubDashboard
  attr_reader :repos, :followers, :following

  def initialize
    @repos = GithubRepo.all
    @followers = GithubFollower.followers
    @following = GithubFollower.following
  end

  def self.create
    GithubRepo.create
    GithubFollower.create
    new
  end
end
