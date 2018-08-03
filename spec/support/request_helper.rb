module RequestHelper
  def json_response
    JSON.parse(response.body)
  end

  def auth_token_for(user)
    post "/api/v1/sessions", params: { email: user.email, password: user.password }
    expect(response.status).to eq(201)
    json_response["token"]
  end
end