Rails.application.routes.draw do
  get :movies, to: 'movies#query'
end
