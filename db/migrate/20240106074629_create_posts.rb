class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :admin_id, null: false
      t.string :title, null: false, :default => ""
      t.text :content, null: false

      t.timestamps
    end
  end
end
