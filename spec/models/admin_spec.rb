require 'rails_helper'

describe 'Adminモデルのテスト', Admin do
  describe 'バリデーションのテスト' do

    it "name,email,password,password_confimationがある場合は登録できること" do
        admin1 = FactoryBot.create(:admin)
        admin1.valid?
        expect(admin1).to be_valid
    end

    it "nameがない場合は登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.name = nil
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Name can't be blank")
    end

    it "nameが21文字以上の場合は登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.name = "あああああああああああああああああああああ"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Name is too long (maximum is 20 characters)")
    end

    it "emailがない場合は登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.email = nil
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email can't be blank")
    end

    it "emailが重複していたら登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin2 = FactoryBot.create(:admin)
        admin1.email = admin2.email
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email has already been taken")
    end

    it 'メールアドレスが "@" を含まない場合は無効であること' do
        admin1 = FactoryBot.create(:admin)
        admin1.email = "example.com"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email が正しい形式ではありません")
    end

    it 'メールアドレスがドメイン部分を含まない場合は無効であること' do
        admin1 = FactoryBot.create(:admin)
        admin1.email = "user@"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email が正しい形式ではありません")
    end

    it 'メールアドレスが "." でドメインを区切らない場合は無効であること' do
        admin1 = FactoryBot.create(:admin)
        admin1.email = "user@examplecom"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email is not an email")
    end

    it 'メールアドレスがスペースを含む場合は無効であること' do
        admin1 = FactoryBot.create(:admin)
        admin1.email = "user@example.com with space"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email が正しい形式ではありません")
    end

    it 'メールアドレスが無効な文字を含む場合は無効であること' do
        admin1 = FactoryBot.create(:admin)
        admin1.email = "user#example.com"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email が正しい形式ではありません")

        admin1 = FactoryBot.create(:admin)
        admin1.email = "user@example,com"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email が正しい形式ではありません")
    end

    it 'メールアドレスが連続するドットを含む場合は無効であること' do
        admin1 = FactoryBot.create(:admin)
        admin1.email = "user@example..com"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Email が正しい形式ではありません")
    end

    it "passwordとpassword_confimationが一致しない場合は登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.password = "password"
        admin1.password_confirmation = "password123"
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordとpassword_confimationがない場合は登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.password = nil
        admin1.password_confirmation = nil
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end

    it "passwordとpassword_confimationが8文字未満だと登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.password = "Pass123"
        admin1.password_confirmation = admin1.password
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it "passwordとpassword_confimationに大文字が含まれていないと登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.password = "password123"
        admin1.password_confirmation = admin1.password
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Password は大文字、小文字、数字を含む必要があります")
    end

    it "passwordとpassword_confimationに小文字が含まれていないと登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.password = "PASSWORD123"
        admin1.password_confirmation = admin1.password
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Password は大文字、小文字、数字を含む必要があります")
    end

    it "passwordとpassword_confimationに数字が含まれていないと登録できないこと" do
        admin1 = FactoryBot.create(:admin)
        admin1.password = "PASSWORD"
        admin1.password_confirmation = admin1.password
        admin1.valid?
        expect(admin1.errors.full_messages).to include("Password は大文字、小文字、数字を含む必要があります")
    end
  end
end