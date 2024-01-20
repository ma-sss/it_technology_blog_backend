require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Posts', type: :request do
  describe 'GET  /api/v1/admin/posts' do
    it '全てのポストを取得する' do
      FactoryBot.create_list(:post, 10)
  
      get '/api/v1/admin/posts'
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 正しい数のデータが返されたか確認する。
      expect(json['data'].length).to eq(10)
    end
  end

  describe 'GET  /api/v1/admin/posts/:id ' do
    let(:admin) { FactoryBot.create(:admin) }

    it '特定のpostを取得する' do
      post = Post.create(admin_id: admin.id, title: 'test-title', content: 'test-content')
  
      get "/api/v1/admin/posts/#{post.id}"
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 要求した特定のポストのみ取得した事を確認する
      expect(json['data']['admin_id']).to eq(post.admin_id)
      expect(json['data']['title']).to eq(post.title)
      expect(json['data']['content']).to eq(post.content)
    end
  end

  describe 'POST #create' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it '新しいpostを作成する' do
      valid_params = { title: 'test-title', content: 'test-content' }

      # データが作成されている事を確認
      expect { 
        post "/api/v1/admin/1/post", 
        params: { post: valid_params }, 
        headers: auth_headers 
      }.to change(Post, :count).by(+1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH #updata' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'postの編集を行う' do
      post = Post.create(admin_id: 1, title: 'test-title', content: 'test-content')

      valid_params = { title: 'updata-test-title', content: 'updata-test-content' }

      # データが編集されている事を確認 
      patch "/api/v1/admin/posts/#{post.id}", 
      params: { post: valid_params }, 
      headers: auth_headers 

      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      #データが更新されている事を確認
      expect(json['data']['title']).to eq('updata-test-title')
      expect(json['data']['content']).to eq('updata-test-content')
    end
  end

  describe 'DELETE #destroy' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'postを削除する' do
      post = Post.create(admin_id: 1, title: 'test-title', content: 'test-content')

      #データが削除されている事を確認
      expect{ delete "/api/v1/admin/posts/#{post.id}", headers: auth_headers}.to change(Post, :count).by(-1) 

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end