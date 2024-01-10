# frozen_string_literal: true

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  validates :name, presence: true,
                   length: { minimum: 1, maximum: 20 } # 名前の文字数範囲を設定
  validates :email, presence: true, # メールアドレスが空でないことを確認
                    uniqueness: true,
                    length: { maximum: 320 }, # メールアドレスの最大文字数を設定
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "が正しい形式ではありません" } # メールアドレスのフォーマットを確認
  validates :password, presence: true,
                       length: { minimum: 8 }, # パスワードの最小文字数を設定
                       format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/, message: "は大文字、小文字、数字を含む必要があります" } # パスワードの強度を確認
  validates :password_confirmation, presence: true
end
