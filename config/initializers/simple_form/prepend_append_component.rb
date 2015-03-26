module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module Prepend
      # Name of the component method
      def prepend(wrapper_options = nil)
        @prepend ||= begin
          options[:prepend].to_s.html_safe if options[:prepend].present?
        end
      end

      # Used when the prepend is optional
      def has_prepend?
        prepend.present?
      end
    end

    # Needs to be enabled in order to do automatic lookups
    module Append
      # Name of the component method
      def append(wrapper_options = nil)
        @append ||= begin
          options[:append].to_s.html_safe if options[:append].present?
        end
      end

      # Used when the append is optional
      def has_append?
        append.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Prepend)
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Append)
