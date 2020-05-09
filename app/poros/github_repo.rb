require_relative 'connectable'

class GithubRepo
  extend Connectable
  @all = []
  class << self
    attr_reader :all
    def create(current_user)
      conn = Connectable.conn('https://api.github.com', current_user)
      resp = conn.get('/user/repos')
      repos = JSON.parse(resp.body, symbolize_names: true)
      repos.each do |repo|
        @all << GithubRepo.new(repo[:name], repo[:owner][:repos_url])
      end
    end
  end
  attr_reader :name, :url

  def initialize(name, url)
    @name = name
    @url = url
  end
end
