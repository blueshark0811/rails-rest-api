class UserContext
  attr_reader :user, :organization, :params

  def initialize(user = nil, organization = nil, params = nil)
    @user = user
    @organization = organization
    @params = params
  end
end
