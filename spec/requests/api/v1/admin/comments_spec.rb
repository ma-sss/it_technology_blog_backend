require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Comments', type: :request do
  describe 'GET /api/v1/admin/comments/:id' do
    it '特定のcommentを取得する' do
      comment = Comment.create(post_id: 1, text: '投稿いいね！')
  
      get "/api/v1/admin/comments/#{comment.id}"
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 要求した特定のcommentのみ取得した事を確認する
      expect(json['data']['admin_id']).to eq(comment.admin_id)
      expect(json['data']['text']).to eq(comment.text)
    end
  end

  describe 'comment #create' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it '新しいcommentを作成する' do
      valid_params = { post_id: 1, text: '投稿いいね！' }

      # データが作成されている事を確認
      expect { 
        post "/api/v1/admin/1/comment", 
        params: { comment: valid_params }, 
        headers: auth_headers 
      }.to change(Comment, :count).by(+1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH #updata' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'commentの編集を行う' do
      comment = Comment.create(post_id: 1, text: 'test-text')

      valid_params = { text: 'updata-test-text' }

      # データが編集されている事を確認 
      patch "/api/v1/admin/comments/#{comment.id}", 
      params: { comment: valid_params }, 
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

    it 'commentを削除する' do
      comment = Comment.create(post_id: 1, text: 'test-text')

      #データが削除されている事を確認
      expect{ delete "/api/v1/admin/comments/#{comment.id}", headers: auth_headers}.to change(Comment, :count).by(-1) 

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end