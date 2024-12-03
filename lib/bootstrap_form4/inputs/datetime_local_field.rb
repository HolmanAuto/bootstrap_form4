# frozen_string_literal: true

module BootstrapForm4
  module Inputs
    module DatetimeLocalField
      extend ActiveSupport::Concern
      include Base

      included do
        bootstrap_field :datetime_local_field
      end
    end
  end
end
