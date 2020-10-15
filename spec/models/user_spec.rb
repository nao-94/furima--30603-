require 'rails_helper'     # bundle exec rspec spec/models/user_spec.rbでターミナル実行  #user.errors.full_

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname、last_name、first_name、last_name_kana、first_name_kana、email、password、password_confirmation、birth_dayが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameがない場合は登録できないこと' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors[:nickname]).to include("can't be blank")
    end

    it 'emailがない場合は登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'emailに@がない場合は登録できないこと ' do
      @user.email = 'aaaaaa'
      @user.valid?
      expect(@user.errors[:email]).to include('is invalid')
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)          # FactoryBot.build(:user)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordがない場合は登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'passwordが6文字以上で、英数字の組み合わせであれば登録できること' do
      @user.password = 'a0b1c2'
      @user.password_confirmation = 'a0b1c2'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'passwordが数字のみの場合は登録できないこと' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors[:password]).to include('is invalid')
    end

    it 'passwordが英文字のみの場合は登録できないこと' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors[:password]).to include('is invalid')
    end

    it 'password_confirmationがない場合は登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'passwordとpassword_confirmationが一致していない場合は登録できないこと' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'bbbbbb'
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'last_nameがない場合は登録できないこと' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it 'first_nameがない場合は登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'last_name_kanaがない場合は登録できないこと' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("can't be blank")
    end

    it 'first_name_kanaがない場合は登録できないこと' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("can't be blank")
    end

    it 'birth_dayがない場合は登録できないこと' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors[:birth_day]).to include("can't be blank")
    end

    it 'last_nameが全角文字であれば登録できること' do
      @user.last_name = 'ぜんかく'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'first_nameが全角文字であれば登録できること' do
      @user.first_name = 'ぜんかく'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'last_name_kanaが全角カナ文字であれば登録できること' do
      @user.last_name_kana = 'ゼンカクカナ'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'first_name_kanaが全角カナ文字であれば登録できること' do
      @user.first_name_kana = 'ゼンカクカナ'
      @user.valid?
      expect(@user).to be_valid
    end
  end
end
