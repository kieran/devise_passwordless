module DevisePasswordless
  module Generators
    class DevisePasswordlessGenerator < Rails::Generators::NamedBase
      namespace "devise_passwordless"

      desc "Add :passwordless directive in the given model. Also generate migration for ActiveRecord"

      def inject_devise_passwordless_content
        path = File.join("app", "models", "#{file_path}.rb")
        inject_into_file(path, "passwordless, :", :after => "devise :") if File.exists?(path)
      end

      hook_for :orm
    end
  end
end
