class Comment < ApplicationRecord
    belongs_to :admin, optional: true
    belongs_to :user, dependent: :destroy, optional: true
    belongs_to :post
    has_many :reply, dependent: :destroy
    validates :post_id, presence: true
    validates :text, presence: true, length: { maximum: 1000 } # textの文字数範囲を設定
end
