class User < ApplicationRecord
    has_one :comment
    has_one :reply
    validates :name, presence: true,
                     uniqueness: true,
                     length: { maximum: 20 } # 名前の文字数範囲を設定
end
