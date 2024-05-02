RSpec.describe "registrations", type: :request do
  describe "POST /new" do
    it "creates a buyer user" do
      post(
        create_registration_url,
        headers: {"Accept" => "application/json"},
        params: {
          user: {
            email: "admin_user@example.com",
            password: "123456",
            password_confirmation: "123456",
            role: :buyer
          }
        }
      )
      user = User.find_by(email: "admin_user@example.com")
      expect(response).to be_successful
      expect(user).to be_buyer
     end
   end
end