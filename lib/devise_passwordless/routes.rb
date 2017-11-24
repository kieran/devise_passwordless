module ActionDispatch::Routing
  class Mapper
    protected
    def devise_passwordless(mapping, controllers)
      resources :passwordless,
        param: :token,
        only: [:new, :create, :show],
        path: mapping.path_names[:passwordless],
        controller: controllers[:passwordless]
    end
  end
end
