require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "POST /create" do
    it "returns http success" do
      post "/password_reset", params: { email: 'test@mail.ru' }
      expect(response).to redirect_to(new_session_path)
    end
  end

end
