TechReviewSite::Application.routes.draw do

  devise_for :users
  resources :users, only: :show
  resources :products, only: :show do
    resources :reviews, only: [:new, :create]
    # get 'products/:product_id/reviews/new' => 'reviews#new'   上記と同じ意味
    # post 'products/:product_id/reviews' => 'reviews#create'   上記と同じ意味
    collection do
      get 'search'
    end
  end
  root 'products#index'

end
