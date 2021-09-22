Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :users do
        scope '/:id', :as => 'user' do
          resources :subscriptions, only: :index
        end
      end
    end
  end
end
