# frozen_string_literal: true

module BootstrapForm4
  module Inputs
    module TextArea
      extend ActiveSupport::Concern
      include Base

      included do
        bootstrap_field :text_area
      end
    end
  end
end
