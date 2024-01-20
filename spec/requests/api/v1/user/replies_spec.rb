require 'rails_helper'

RSpec.describe 'Api::V1::User::Replies', type: :request do
  describe 'GET  /api/v1/user/replies' do
    it '全てのreplyを取得する' do
      FactoryBot.create_list(:reply, 10)
  
      get '/api/v1/user/replies'
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 正しい数のデータが返されたか確認する。
      expect(json['data'].length).to eq(10)
    end
  end

  describe 'GET  /api/v1/user/replies/:id ' do
    let(:user) { FactoryBot.create(:user) }

    it '特定のreplyを取得する' do
      reply = Reply.create(comment_id: 1, user_id: user.id, text: '投稿いいね！')
  
      get "/api/v1/user/replies/#{reply.id}"
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 要求した特定のreplyのみ取得した事を確認する
      expect(json['data']['comment_id']).to eq(reply.comment_id)
      expect(json['data']['user_id']).to eq(reply.user_id)
      expect(json['data']['text']).to eq(reply.text)
    end
  end

  describe 'reply #create' do
    it '新しいreplyを作成する' do
      reply_valid_params = { text: 'test-text' }
      user_valid_params = { name: '一般ユーザー' }

      # replyデータとuserデータが作成されている事を確認
      expect { 
        post "/api/v1/user/comment/1/reply", 
        params: { reply: reply_valid_params, user: user_valid_params }
      }.to change(Reply, :count).by(+1)
      .and change(User, :count).by(+1)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH #updata' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'replyの編集を行う' do
      reply = Reply.create(comment_id: 1, user_id: 1, text: "コメントいいね！")

      valid_params = { text: '編集後のコメントいいね！' }

      # データが編集されている事を確認 
      patch "/api/v1/user/replies/#{reply.id}", 
      params: { reply: valid_params }, 
      headers: auth_headers 

      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)

      #データが更新されている事を確認
      expect(json['data']['text']).to eq('編集後のコメントいいね！')
    end
  end

  describe 'DELETE #destroy' do
    # adminがログインしている状態を作る
    let(:admin) { FactoryBot.create(:admin) }
    let(:auth_headers) { admin.create_new_auth_token }

    it 'replyを削除する' do
      reply = Reply.create(comment_id: 1, user_id: 1, text: "投稿いいね！")

      #データが削除されている事を確認
      expect{ delete "/api/v1/user/replies/#{reply.id}", headers: auth_headers}.to change(Reply, :count).by(-1) 

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
  end
end