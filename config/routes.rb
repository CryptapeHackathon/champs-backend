Rails.application.routes.draw do
  resources :users do
    post 'bind', to: "users#bind"
  end

  resources :hackathons do
    resources :teams do
      post 'vote-cli', to: "teams#vote_cli"
      get 'votes', to: "teams#votes"
    end

    collection do
      post 'create-cli', to: "hackathons#create_cli"
      post 'encode', to: "hackathons#encode"
    end
    post 'cli', to: "hackathons#cli"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
