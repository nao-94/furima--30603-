require 'rails_helper'           # bundle exec rspec spec/models/item_spec.rbでターミナル実行

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品登録がうまくいくとき' do
      it 'image、name、descripition、category_id、condition＿id、postage_payer_id、prefecture_id、handing_time_id、priceがある場合は登録できること' do
        expect(@item).to be_valid
      end
    end

    context '商品登録がうまくいかないとき' do
      it 'imageがない場合は登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors[:image]).to include("can't be blank")
      end

      it 'nameがない場合は登録できないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors[:name]).to include("can't be blank")
      end

      it 'descriptionがない場合は登録できないこと' do
        @item.description = nil
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'category_idがない場合は登録できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors[:category_id]).to include("can't be blank")
      end

      it 'condition_idがない場合は登録できないこと' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors[:condition_id]).to include("can't be blank")
      end

      it 'postage_payer_idがない場合は登録できないこと' do
        @item.postage_payer_id = nil
        @item.valid?
        expect(@item.errors[:postage_payer_id]).to include("can't be blank")
      end

      it 'prefecture_idがない場合は登録できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'handing_time_idがない場合は登録できないこと' do
        @item.handing_time_id = nil
        @item.valid?
        expect(@item.errors[:handing_time_id]).to include("can't be blank")
      end

      it 'priceがない場合は登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it 'priceが299以下だと登録できないこと' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors[:price]).to include('must be greater than or equal to 300')
      end

      it 'priceが10000000以上だと登録できないこと' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors[:price]).to include('must be less than or equal to 9999999')
      end

      it 'priceが全角数字だと登録できないこと' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors[:price]).to include('is not a number')
      end
    end
  end
end
