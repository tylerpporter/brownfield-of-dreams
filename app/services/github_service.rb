class GithubService
  @user = nil
  class << self
    attr_accessor :user
    def repos
      resp = conn.get('/user/repos')
      JSON.parse(resp.body, symbolize_names: true)
    end

    def follower(type)
      JSON.parse(conn.get("/user/#{type}")
          .body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new('https://api.github.com') do |req|
        req.headers[:Authorization] = "token #{@user.token}"
      end
    end
  end
end
