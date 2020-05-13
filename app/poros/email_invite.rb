class EmailInvite
  def initialize(github_user, user)
    @github_user = github_user
    @user = user
  end

  def message
    "Hello #{@github_user[:login]}, #{@user.github_handle} has invited you to\
    join Brownfield."
  end
end
