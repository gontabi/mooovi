class RankingController < ApplicationController
  layout 'review_site'
  before_action :ranking
  def ranking
    product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    @ranking = product_ids.map{|id| Product.find id}
  end
end
#groupメソッドでひとつのカラムの値ごとにレコードをまとめます
#order('count_product_id DESC')によってまとまりの数が多い順にソート
#limitメソッドで上位5つのまとまりのみ取得
#countメソッドにより、まとまりのproduct_idカラムの値をキー、同カラムの同じ値のレコードの数をバリューとするセットが5つ入ったハッシュを生成
#ハッシュのキーのみの配列を返してくれるkeysメソッドを使用し、最終的にレビューの数が多いproduct上位5件のidが順番に並んだ配列を取得
