class Post < ApplicationRecord
    belongs_to :admin
    has_many :comment, dependent: :destroy
    enum category: { explanation: 'explanation', frontend: 'frontend', backend: 'backend', other: 'other', tentative: 'tentative' }
    validates :category, presence: true
    validates :admin_id, presence: true
    validates :title, presence: true,
                     uniqueness: true,
                     length: { maximum: 100 } # タイトルの文字数範囲を設定
    validates :content, presence: true
end
