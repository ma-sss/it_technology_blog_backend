require 'rails_helper'

RSpec.describe 'Api::V1::User::Comments', type: :request do
  describe 'GET  /api/v1/user/comments' do
    it '全てのcommentを取得する' do
      FactoryBot.create_list(:comment, 10)
  
      get '/api/v1/user/comments'
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 正しい数のデータが返されたか確認する。
      expect(json['data'].length).to eq(10)
    end
  end

  describe 'GET  /api/v1/user/comments/:id ' do
    let(:user) { FactoryBot.create(:user) }

    it '特定のcommentを取得する' do
      comment = Comment.create(post_id: 1, user_id: user.id, text: '投稿いいね！')
  
      get "/api/v1/user/comments/#{comment.id}"
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 要求した特定のcommentのみ取得した事を確認する
      expect(json['data']['user_id']).to eq(comment.user_id)
      expect(json['data']['text']).to eq(comment.text)
    end
  end

  describe 'comment #create' do
    it '新しいcommentを作成する' do
      comment_valid_params = { post_id: 1, text: 'test-text' }
      user_valid_params = { name: '一般ユーザー' }

      # commentデータとuserデータが作成されている事を確認
      expect { 
        post "/api/v1/user/comments", 
        params: { comment: comment_valid_params, user: user_valid_params }
      }.to change(Comment, :count).by(+1)
      .and change(User, :count).by(+1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH #updata' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'commentの編集を行う' do
      comment = Comment.create(post_id: 1, user_id: 1, text: "投稿いいね！")

      valid_params = { text: '編集後の投稿いいね！' }

      # データが編集されている事を確認 
      patch "/api/v1/user/comments/#{comment.id}", 
      params: { comment: valid_params }, 
      headers: auth_headers 

      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      #データが更新されている事を確認
      expect(json['data']['text']).to eq('編集後の投稿いいね！')
    end
  end

  describe 'DELETE #destroy' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'commentを削除する' do
      comment = Comment.create(post_id: 1, user_id: 1, text: "投稿いいね！")

      #データが削除されている事を確認
      expect{ delete "/api/v1/user/comments/#{comment.id}", headers: auth_headers}.to change(Comment, :count).by(-1) 

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end