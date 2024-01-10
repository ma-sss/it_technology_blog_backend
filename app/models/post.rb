class Post < ApplicationRecord
    validates :admin_id, presence: true
    validates :title, presence: true,
                     uniqueness: true,
                     length: { minimum: 1, maximum: 30 } # タイトルの文字数範囲を設定
    validates :content, presence: true,
                     length: { minimum: 1, maximum: 5000 } # 内容の文字数範囲を設定
end
