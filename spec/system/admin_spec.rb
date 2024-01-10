require 'rails_helper'

RSpec.describe 'Admin Sign-up', type: :system do
  it 'allows admin user to sign up' do
    params = {
      name: 'よさこいチーム123',
      email: 'newadmin@example.com',
      password: 'Password123',
      password_confirmation: 'Password123'
    }

    post '/api/v1/admin', params: params
    
    expect(response).to have_http_status(200) # 成功ステータスコード
    expect(response.headers['access-token']).to be_present # Access-Tokenが含まれていること
    expect(JSON.parse(response.body)['status']).to eq('success') # レスポンスのステータスがsuccessであること
    expect(Admin.count).to eq(1) # adminユーザーが1つ作成されたことを確認
  end
  it 'allows admin user to sign up' do
    params = {
      name: 'よさこいチーム123',
      email: 'newadmin@example.com',
      password: 'password123', #大文字を入れていない
      password_confirmation: 'password123' #大文字を入れていない
    }

    post '/api/v1/admin', params: params
    
    expect(response).to have_http_status(422) # Unprocessable Entityステータスコード
    expect(JSON.parse(response.body)['status']).to eq('error') # エラーステータス
    expect(Admin.count).to eq(0) # ユーザーは作成されていないことを確認
  end
end