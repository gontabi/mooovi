class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title   #作品名のカラム情報の追加
      t.text :image_url   #作品画像のURLのカラム情報の追加
      t.timestamps
    end
  end
end
