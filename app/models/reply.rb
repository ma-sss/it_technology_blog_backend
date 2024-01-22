class Reply < ApplicationRecord
    validates :comment_id, presence: true
    validates :text, presence: true, length: { maximum: 1000 } # textの文字数範囲を設定
end
