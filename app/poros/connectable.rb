module Connectable
  def self.conn(url, current_user)
    Faraday.new(url) do |req|
      req.headers[:Authorization] = "token #{current_user.token}"
    end
  end
end
