class UserContext
  attr_reader :user, :organization

  def initialize(user = nil, organization = nil)
    @user = user
    @organization = organization
  end
end
