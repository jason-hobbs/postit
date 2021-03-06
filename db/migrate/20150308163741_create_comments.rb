class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, index: true
      t.references :post, index: true
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
