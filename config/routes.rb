Rails.application.routes.draw do
	namespace :admin do
		get 'consul' => 'consul#index'
		get 'consul/service'
		get 'consul/status'
		get 'domains' => 'domains#index'
		get 'config' => 'config#index'
		get 'preview' => 'preview#index'
		get 'preview/show'
	end
	get 'admin' => 'admin#index'

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# Serve websocket cable requests in-process
	# mount ActionCable.server => '/cable'
end
