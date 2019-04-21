class ReviewsController < RankingController
#ログインしていない状態でレビューの投稿をしようとすると、ログイン画面にリダイレクト
before_action :authenticate_user!, only: :new
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    # Review.create(create_params)
    Review.create(create_params)
    redirect_to controller: :products, action: :index# トップページにリダイレクトする
  end

  private
  def create_params
    # createメソッドの引数は、(保存したいカラム: 保存する値, 保存したいカラム: 保存する値,・・・)という形式
    params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id], user_id: current_user.id)


  end
end
