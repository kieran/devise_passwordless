module DevisePasswordless
  module Mapping
    private
    def default_controllers(options)
      options[:controllers] ||= {}
      options[:controllers][:passwordless] ||= "devise/passwordless"
      super
    end
  end
end
