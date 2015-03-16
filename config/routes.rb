Rails.application.routes.draw do
  root :to => 'welcome#index', :as => 'home'
  post 'get_notifications', :to => 'welcome#get_notifications'
  post 'action/read', :to => 'actions#read'
  post 'action/unread', :to => 'actions#unread'
end
