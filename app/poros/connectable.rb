module Connectable
  def self.conn(url)
    Faraday.new(url) do |req|
      req.headers[:Authorization] = "token #{ENV['GITHUB_TOKEN']}"
    end
  end
end
