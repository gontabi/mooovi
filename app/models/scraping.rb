class Scraping
  def self.movie_urls
    # 映画の個別ページのURLを取得
    # get_product(link)を呼び出す
    links = []   #①linksという配列の空枠を作る
    agent = Mechanize.new   #②Mechanizeクラスのインスタンスを生成する
    next_url = ""   #パスのみを切り離してnext_urlという変数

    while true do
      #8行目で切り離していたパスの部分をホスト名に足します。こうすることで、ひとつのURLになりきちんとgetメソッドでHTML情報を取得できます。
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)   #③映画の全体ページのURLを取得
      elements = current_page.search('.entry-title a')   #④全体ページから映画20件の個別URLのタグを取得
      elements.each do |ele|
        links << ele.get_attribute('href')   #⑤個別URLのタグからhref要素を取り出し、links配列に格納する
      end

      next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')

    end
    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)   #⑥get_productを実行する際にリンクを引数として渡す
    end
  end


  def self.get_product(link)
    # 「作品名」と「作品画像のURL」をスクレイピング
    # スクレイピングした「作品名」と「作品画像のURL」をProductsテーブルに保存
    agent = Mechanize.new   #⑦Mechanizeクラスのインスタンスを生成する
    page = agent.get(link)   #⑧映画の個別ページのURLを取得
    title = page.at('.entry-title').inner_text   #⑨inner_textメソッドを利用し映画のタイトルを取得
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')#①⓪image_urlがあるsrc要素のみを取り出す

    product = Product.where(title: title, image_url: image_url).first_or_initialize
#whereメソッド:titleカラムに変数titleの値が一致とimage_urlカラムに変数image_urlの値が一致という二つの条件
#①①newメソッド、saveメソッドを使い、 スクレイピングした「映画タイトル」と「作品画像のURL」をproductsテーブルに保存
    product.save
  end
end
