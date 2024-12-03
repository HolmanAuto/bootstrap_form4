# frozen_string_literal: true

module BootstrapForm4
  module Inputs
    module DateSelect
      extend ActiveSupport::Concern
      include Base

      included do
        bootstrap_select_group :date_select
      end
    end
  end
end
