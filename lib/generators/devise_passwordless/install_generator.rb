module DevisePasswordless
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Add DevisePasswordless config variables to the Devise initializer and copy DevisePasswordless locale files to your application."
    end
  end
end
