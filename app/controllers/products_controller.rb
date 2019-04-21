class ProductsController < RankingController
  #ログインしていない状態でレビューの投稿をしようとすると、ログイン画面にリダイレクト
  before_action :authenticate_user!, only: :search
  def index
    # productsテーブルから最新順に作品を２０件取得する
    @products = Product.order('id ASC').limit(20)  #idを最新版順で20件表示

  end

  def show
    # productsテーブルから該当するidの作品情報を取得し@productの変数へ代入する処理を書いて下さい
    @product = Product.find(params[:id])
    # @product = Product.new # 問題3ではこのコードは消して新しくコードを書いてください
  end

  def search
    # 検索フォームのキーワードをあいまい検索して、productsテーブルから20件の作品情報を取得する
    @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end
end
