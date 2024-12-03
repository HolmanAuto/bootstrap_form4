# NOTE: The rich_text_area and rich_text_area_tag helpers are defined in a file with a different
# name and not in the usual autoload-reachable way.
# The following line is definitely need to make `bootstrap_form` work.
if ::Rails::VERSION::STRING > "6"
  require Gem::Specification.find_by_name("actiontext").gem_dir + # rubocop:disable Rails/DynamicFindBy
          "/app/helpers/action_text/tag_helper"
end
require "action_view"
require "action_pack"
require "bootstrap_form4/action_view_extensions/form_helper"

module BootstrapForm4
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Configuration
    autoload :FormBuilder
    autoload :FormGroupBuilder
    autoload :FormGroup
    autoload :Components
    autoload :Inputs
    autoload :Helpers
  end

  class << self
    def eager_load!
      super
      BootstrapForm4::Components.eager_load!
      BootstrapForm4::Helpers.eager_load!
      BootstrapForm4::Inputs.eager_load!
    end

    def config
      @config ||= BootstrapForm4::Configuration.new
    end

    def configure
      yield config
    end
  end

  mattr_accessor :field_error_proc
  # rubocop:disable Style/ClassVars
  @@field_error_proc = proc do |html_tag, _instance_tag|
    html_tag
  end
  # rubocop:enable Style/ClassVars
end

require "bootstrap_form4/engine" if defined?(Rails)
