class Reply < ApplicationRecord
    belongs_to :admin
    belongs_to :user, dependent: :destroy
    belongs_to :comment
    validates :comment_id, presence: true
    validates :text, presence: true, length: { maximum: 1000 } # textの文字数範囲を設定
end
