class Comment < ApplicationRecord
    validates :post_id, presence: true
    validates :text, presence: true, length: { minimum: 1, maximum: 1000 } # textの文字数範囲を設定
end
