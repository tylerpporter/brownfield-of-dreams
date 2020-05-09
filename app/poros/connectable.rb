module Connectable
  def self.conn(url, current_user)
    Faraday.new(url) do |req|
      require "pry"; binding.pry
      req.headers[:Authorization] = "token #{current_user.token}"
    end
  end
end
