class GithubRepo
  @all = []
  class << self
    attr_reader :all
    def create
      GithubService.repos.each do |repo|
        @all << new(repo[:name], repo[:owner][:html_url])
      end
    end
  end
  attr_reader :name, :url

  def initialize(name, url)
    @name = name
    @url = url
  end
end
