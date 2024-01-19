require 'rails_helper'

describe 'Replyモデルのテスト', Reply do
  describe 'バリデーションのテスト' do
    
    it "comment_id,text,がある場合は登録できること" do
        reply1 = FactoryBot.create(:reply)
        reply1.valid?
        expect(reply1).to be_valid
    end

    it "comment_idがない場合は登録できないこと" do
        reply1 = FactoryBot.create(:reply)
        reply1.comment_id = nil
        reply1.valid?
        expect(reply1.errors.full_messages).to include("Comment can't be blank")
    end

    it "textがない場合は登録できないこと" do
        reply1 = FactoryBot.create(:reply)
        reply1.text = nil
        reply1.valid?
        expect(reply1.errors.full_messages).to include("Text can't be blank", "Text is too short (minimum is 1 character)")
    end

    it "textが1001文字以上の場合は登録できないこと" do
        reply1 = FactoryBot.create(:reply)
        reply1.text = "いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！いいね！！"
        reply1.valid?
        expect(reply1.errors.full_messages).to include("Text is too long (maximum is 1000 characters)")
    end
  end
end