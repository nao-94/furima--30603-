class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :handing_time

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :price, numericality: { only_integr: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :category_id, numericality: { other_than: 1 }
    validates :condition_id, numericality: { other_than: 1 }
    validates :postage_payer_id, numericality: { other_than: 1 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :handing_time_id, numericality: { other_than: 1 }
    validates :category_id, numericality: { other_than: 1 }
  end
end
