Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :calculate do
    get 'income-tax', to: 'income_tax#calculate'
    get 'gct', to: 'gct#calculate'
    get 'property-tax', to: 'property_tax#calculate'
    post 'income-tax/batch', to: 'income_tax#calculate_batch'
    post 'nis/batch', to: 'nis#calculate_batch_nis'
    post 'nht/batch', to: 'nht#calculate_batch_nht'
    post 'et/batch', to: 'et#calculate_batch_et'
    post 'consolidated_taxes', to: 'consolidated_taxes#calculate_all_taxes'
  end  
end
