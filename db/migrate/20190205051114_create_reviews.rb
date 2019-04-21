class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :nickname   #カラム追加
      t.integer :rate   #カラム追加
      t.text :review   #カラム追加
      t.integer :product_id   #カラム追加
      t.timestamps
    end
  end
end
