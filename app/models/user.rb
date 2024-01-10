class User < ApplicationRecord
    validates :name, presence: true,
                     uniqueness: true,
                     length: { minimum: 1, maximum: 20 } # 名前の文字数範囲を設定
end
