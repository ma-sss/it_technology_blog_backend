class Post < ApplicationRecord
    enum category: { frontend: 'frontend', backend: 'backend', other: 'other', tentative: 'tentative' }
    validates :category, presence: true
    validates :admin_id, presence: true
    validates :title, presence: true,
                     uniqueness: true,
                     length: { maximum: 100 } # タイトルの文字数範囲を設定
    validates :content, presence: true,
                     length: { maximum: 10000 } # 内容の文字数範囲を設定
end
