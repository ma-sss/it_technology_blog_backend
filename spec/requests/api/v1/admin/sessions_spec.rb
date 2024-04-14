require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Sessions', type: :request do
  describe 'Admin #create' do
    it 'adminでログインする' do
      # サインアップする
      post "/api/v1/admin", params: { registration: { email: "admin_settion_test@example.com", password: "Password123", password_confirmation: "Password123" } }

      expect(response.status).to eq(200)

      valid_params = { email: "admin_settion_test@example.com", password: "Password123" }

      #  ログインする
      post "/api/v1/admin/sign_in", params: { session: valid_params }

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      # ユーザーセッションが作成されていることを確認
      expect(response.headers['uid']).to be_present
      expect(response.headers['access-token']).to be_present
      expect(response.headers['client']).to be_present
    end
  end
end