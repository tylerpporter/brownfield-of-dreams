class GithubDashboard
  attr_reader :repos, :followers, :following

  def initialize
    @repos = GithubRepo.all
    @followers = GithubFollower.followers.uniq
    @following = GithubFollower.following.uniq
  end

  def self.create
    GithubRepo.create
    GithubFollower.create
    new
  end
end
