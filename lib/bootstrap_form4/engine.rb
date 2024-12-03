# frozen_string_literal: true

require "rails/railtie"

module BootstrapForm4
  class Engine < Rails::Engine
    config.eager_load_namespaces << BootstrapForm4
    config.autoload_paths << File.expand_path("lib", __dir__)
  end
end
