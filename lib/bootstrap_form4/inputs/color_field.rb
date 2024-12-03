# frozen_string_literal: true

module BootstrapForm4
  module Inputs
    module ColorField
      extend ActiveSupport::Concern
      include Base

      included do
        bootstrap_field :color_field
      end
    end
  end
end
