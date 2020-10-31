require 'rails_helper'     # bundle exec rspec spec/models/purchase_address_spec.rbでターミナル実行

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    end

    context '商品購入がうまくいくとき' do
      it '全ての項目が正しく入力されている場合に購入出来ること' do
        expect(@purchase_address).to be_valid
      end

      it 'building_nameが空でも購入出来ること' do
        @purchase_address.building_name = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'postal_codeが空の場合購入出来ないこと' do
        @purchase_address.postal_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角ハイフンを含まない場合購入出来ないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'postal_codeが全角の場合購入出来ないこと' do
        @purchase_address.postal_code = '１２３４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)') 
      end

      it 'prefectureが選択されていない場合購入出来ないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank") 
      end

      it 'cityが空の場合購入出来ないこと' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'phone_numberが空の場合購入出来ないこと' do
        @purchase_address.phone_number = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberにハイフンが含まれている場合購入出来ないこと' do
        @purchase_address.phone_number = '090-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid') 
      end

      it 'phone_numberが全角の場合購入出来ないこと' do
        @purchase_address.phone_number = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'カード情報がtoken化されていない場合購入出来ないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it '紐付くitemがない場合購入出来ないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it '紐付くuserがない場合購入出来ないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
