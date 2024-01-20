require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Registrations', type: :request do
  describe 'Admin #create' do
    it '新しいadminを作成する' do
      valid_params = { email: "admin_registration_test@exaple.com", password: "Password123", password_confirmation: "Password123" }

      # データが作成されている事を確認
      expect { 
        post "/api/v1/admin", 
        params: { registration: valid_params }
      }.to change(Admin, :count).by(+1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end