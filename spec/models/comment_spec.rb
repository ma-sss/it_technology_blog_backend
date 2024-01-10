require 'rails_helper'

describe 'Commentモデルのテスト', Comment do
  describe 'バリデーションのテスト' do
    
    it "admin_id,title,がある場合は登録できること" do
        comment1 = FactoryBot.create(:comment)
        comment1.valid?
        expect(comment1).to be_valid
    end

    it "post_idがない場合は登録できないこと" do
        comment1 = FactoryBot.create(:comment)
        comment1.post_id = nil
        comment1.valid?
        expect(comment1.errors.full_messages).to include("Post can't be blank")
    end

    it "textがない場合は登録できないこと" do
        comment1 = FactoryBot.create(:comment)
        comment1.text = nil
        comment1.valid?
        expect(comment1.errors.full_messages).to include("Text can't be blank", "Text is too short (minimum is 1 character)")
    end

    it "textが31文字以上の場合は登録できないこと" do
        comment1 = FactoryBot.create(:comment)
        comment1.text = "いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！！"
        comment1.valid?
        expect(comment1.errors.full_messages).to include("Text is too long (maximum is 1000 characters)")
    end
  end
end