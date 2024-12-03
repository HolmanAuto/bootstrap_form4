# frozen_string_literal: true

module BootstrapForm4
  module Inputs
    module TelephoneField
      extend ActiveSupport::Concern
      include Base

      included do
        bootstrap_field :telephone_field
      end
    end
  end
end
