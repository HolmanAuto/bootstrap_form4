# require 'bootstrap_form4/aliasing'

module BootstrapForm4
  class FormBuilder < ActionView::Helpers::FormBuilder
    attr_reader :layout, :label_col, :control_col, :has_error, :inline_errors,
                :label_errors, :acts_like_form_tag

    include BootstrapForm4::Helpers::Bootstrap

    include BootstrapForm4::FormGroupBuilder
    include BootstrapForm4::FormGroup
    include BootstrapForm4::Components

    include BootstrapForm4::Inputs::Base
    include BootstrapForm4::Inputs::CheckBox
    include BootstrapForm4::Inputs::CollectionCheckBoxes
    include BootstrapForm4::Inputs::CollectionRadioButtons
    include BootstrapForm4::Inputs::CollectionSelect
    include BootstrapForm4::Inputs::ColorField
    include BootstrapForm4::Inputs::DateField
    include BootstrapForm4::Inputs::DateSelect
    include BootstrapForm4::Inputs::DatetimeField
    include BootstrapForm4::Inputs::DatetimeLocalField
    include BootstrapForm4::Inputs::DatetimeSelect
    include BootstrapForm4::Inputs::EmailField
    include BootstrapForm4::Inputs::FileField
    include BootstrapForm4::Inputs::GroupedCollectionSelect
    include BootstrapForm4::Inputs::MonthField
    include BootstrapForm4::Inputs::NumberField
    include BootstrapForm4::Inputs::PasswordField
    include BootstrapForm4::Inputs::PhoneField
    include BootstrapForm4::Inputs::RadioButton
    include BootstrapForm4::Inputs::RangeField
    include BootstrapForm4::Inputs::RichTextArea if Rails::VERSION::MAJOR >= 6
    include BootstrapForm4::Inputs::SearchField
    include BootstrapForm4::Inputs::Select
    include BootstrapForm4::Inputs::TelephoneField
    include BootstrapForm4::Inputs::TextArea
    include BootstrapForm4::Inputs::TextField
    include BootstrapForm4::Inputs::TimeField
    include BootstrapForm4::Inputs::TimeSelect
    include BootstrapForm4::Inputs::TimeZoneSelect
    include BootstrapForm4::Inputs::UrlField
    include BootstrapForm4::Inputs::WeekField

    delegate :content_tag, :capture, :concat, to: :@template

    # rubocop:disable Metrics/AbcSize
    def initialize(object_name, object, template, options)
      @layout = options[:layout] || default_layout
      @label_col = options[:label_col] || default_label_col
      @control_col = options[:control_col] || default_control_col
      @label_errors = options[:label_errors] || false

      @inline_errors = if options[:inline_errors].nil?
                         @label_errors != true
                       else
                         options[:inline_errors] != false
                       end
      @acts_like_form_tag = options[:acts_like_form_tag]
      add_default_form_attributes_and_form_inline options
      super
    end
    # rubocop:enable Metrics/AbcSize

    def add_default_form_attributes_and_form_inline(options)
      options[:html] ||= {}
      options[:html].reverse_merge!(BootstrapForm4.config.default_form_attributes)

      return unless options[:layout] == :inline

      options[:html][:class] = [options[:html][:class], "form-inline"].compact.join(" ")
    end

    def fields_for_with_bootstrap(record_name, record_object=nil, fields_options={}, &block)
      fields_options = fields_for_options(record_object, fields_options)
      record_object.is_a?(Hash) && record_object.extractable_options? &&
        record_object = nil
      fields_for_without_bootstrap(record_name, record_object, fields_options, &block)
    end

    bootstrap_alias :fields_for

    # the Rails `fields` method passes its options
    # to the builder, so there is no need to write a `bootstrap_form` helper
    # for the `fields` method.

    private

    def fields_for_options(record_object, fields_options)
      field_options = fields_options
      record_object.is_a?(Hash) && record_object.extractable_options? &&
        field_options = record_object
      %i[layout control_col inline_errors label_errors].each do |option|
        field_options[option] ||= options[option]
      end
      field_options[:label_col] = field_options[:label_col].present? ? (field_options[:label_col]).to_s : options[:label_col]
      field_options
    end

    def default_layout
      # :default, :horizontal or :inline
      :default
    end

    def default_label_col
      "col-sm-2"
    end

    def offset_col(label_col)
      label_col.gsub(/\bcol-(\w+)-(\d)\b/, 'offset-\1-\2')
    end

    def default_control_col
      "col-sm-10"
    end

    def hide_class
      "sr-only" # still accessible for screen readers
    end

    def control_class
      "form-control"
    end

    def feedback_class
      "has-feedback"
    end

    def control_specific_class(method)
      "rails-bootstrap-forms-#{method.to_s.tr('_', '-')}"
    end
  end
end
