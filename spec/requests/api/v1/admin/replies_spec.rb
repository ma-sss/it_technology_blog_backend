require 'rails_helper'

RSpec.describe 'Api::V1::Admin::replies', type: :request do
  describe 'GET /api/v1/admin/replies/:id' do
    it '特定のreplyを取得する' do
      reply = Reply.create(comment_id: 1, admin_id: 1, text: '投稿いいね！')
  
      get "/api/v1/admin/replies/#{reply.id}"
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 要求した特定のreplyのみ取得した事を確認する
      expect(json['data']['comment_id']).to eq(reply.comment_id)
      expect(json['data']['admin_id']).to eq(reply.admin_id)
      expect(json['data']['text']).to eq(reply.text)
    end
  end

  describe 'reply #create' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it '新しいreplyを作成する' do
      valid_params = { text: '投稿いいね！' }

      # データが作成されている事を確認
      expect { 
        post "/api/v1/admin/1/comment/1/reply", 
        params: { reply: valid_params }, 
        headers: auth_headers 
      }.to change(Reply, :count).by(+1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH #updata' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'replyの編集を行う' do
      reply = Reply.create(comment_id: 1, text: 'test-text')

      valid_params = { text: 'updata-test-text' }

      # データが編集されている事を確認 
      patch "/api/v1/admin/replies/#{reply.id}", 
      params: { reply: valid_params }, 
      headers: auth_headers 
      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      #データが更新されている事を確認
      expect(json['data']['text']).to eq('updata-test-text')
    end
  end

  describe 'DELETE #destroy' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'replyを削除する' do
      reply = Reply.create(comment_id: 1, text: 'test-text')

      #データが削除されている事を確認
      expect{ delete "/api/v1/admin/replies/#{reply.id}", headers: auth_headers}.to change(Reply, :count).by(-1) 

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end