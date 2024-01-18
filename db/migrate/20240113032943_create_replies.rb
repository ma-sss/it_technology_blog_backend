class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.integer :comment_id
      t.integer :user_id
      t.integer :admin_id
      t.text :text

      t.timestamps
    end
  end
end
