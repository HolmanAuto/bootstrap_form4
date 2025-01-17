# frozen_string_literal: true

module BootstrapForm4
  module Inputs
    module MonthField
      extend ActiveSupport::Concern
      include Base

      included do
        bootstrap_field :month_field
      end
    end
  end
end
