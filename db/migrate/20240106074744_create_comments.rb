class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :admin_id
      t.integer :user_id
      t.string :text

      t.timestamps
    end
  end
end
