require 'rails_helper'

describe 'Userモデルのテスト', User do
  describe 'バリデーションのテスト' do
    
    it "name,email,password,password_confimationがある場合は登録できること" do
        user1 = FactoryBot.create(:user)
        user1.valid?
        expect(user1).to be_valid
    end

    it "nameがない場合は登録できないこと" do
        user1 = FactoryBot.create(:user)
        user1.name = nil
        user1.valid?
        expect(user1.errors.full_messages).to include("Nameを入力してください")
    end

    it "既に存在している名前は登録できないこと" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        user1.name = user2.name
        user1.valid?
        expect(user1.errors.full_messages).to include("Nameはすでに存在します")
    end

    it "nameが21文字以上の場合は登録できないこと" do
        user1 = FactoryBot.create(:user)
        user1.name = "あああああああああああああああああああああ"
        user1.valid?
        expect(user1.errors.full_messages).to include("Nameは20文字以内で入力してください")
    end
  end
end