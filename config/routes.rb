Multiupload::Application.routes.draw do
  resources :buckets do
		resources :assets
	end
end
