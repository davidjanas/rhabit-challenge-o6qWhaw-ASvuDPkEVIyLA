require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user, password: "password123") }


  describe '/users' do
    before do
      5.times do
        new_user = create(:user)
        new_user.update!(manager: user)
      end
    end
    it "returns a JWT with valid credentials" do
      headers = {
        "Authorization": "Bearer #{JsonWebToken.encode(id: user.id)}",
      }
      get '/api/users', headers: headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).length).to eq(5)


    end

    it "returns a 401 error with invalid credentials" do
      get '/api/users', headers: { Authorization: "fake_token"}
      expect(response).to have_http_status(401)
    end
  end
end
