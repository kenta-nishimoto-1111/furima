require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザーの新規登録' do
    context '正常に登録ができる場合' do
      it '全ての値が問題なく入っている場合、登録ができる' do
        expect(@user).to be_valid
      end
    end
    context '正常に登録ができない場合' do
      it 'nicknameが空だと登録ができない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'passwordが空だと登録ができない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが６文字以下だと登録ができない' do
        @user.password = 'aA1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英字のみだと登録ができない' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordが半角数字のみだと登録ができない' do
        @user.password = '1111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordに全角英数字が入っていると登録ができない' do
        @user.password = 'ＡＡＡＡＡ１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'emailがないと登録ができない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailがすでに登録されている場合、登録ができない' do
        first_user = FactoryBot.create(:user, email: 'test@test.co.jp')
        second_user = FactoryBot.build(:user, email: 'test@test.co.jp')
        second_user.valid?
        expect(second_user.errors.full_messages).to include("Email has already been taken")
      end
      it '@を含んでいないemailは登録ができない' do
        @user.email = 'test.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'birth_dateが空だと登録ができない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it 'first_nameが空だと登録ができない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外だと登録ができない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'last_nameが空だと登録ができない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外だと登録ができない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it 'first_name_kanaが空だと登録ができない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaが全角ひらがな・漢字だと登録ができない' do
        @user.first_name_kana = 'てすと太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it 'first_name_kanaが半角英数字だと登録ができない' do
        @user.first_name_kana = 'aaa123'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it 'last_name_kanaが空だと登録ができない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaが全角ひらがな・漢字だと登録ができない' do
        @user.last_name_kana = 'てすと太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it 'last_name_kanaが半角英数字だと登録ができない' do
        @user.last_name_kana = 'aaa123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
    end
  end
end