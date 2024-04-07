require "rails_helper"

RSpec.describe "User Requests", type: :request do
    describe "GET /api/user" do
        let!(:user) { User.create(full_name: "Test User", email: "test@test.com", username: "test_user", password: "test123") }
        let!(:token) { JWT.encode({ user_id: user.id }, "test123") }

        it "returns the correct user" do
            get "/api/user", headers: { "Authorization": "Bearer #{token}" }

            json = JSON.parse(response.body)

            expect(json["user"]["id"]).to eq(user.id)
            expect(response.status).to eq(200)
        end
    end
end