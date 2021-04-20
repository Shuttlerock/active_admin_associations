module Formtastic
  module TokenInputDefaultForAssociation
    extend ActiveSupport::Concern

    def default_input_type(method, options = {})
      if @object
        reflection = reflection_for(method)
        return :token if reflection && reflection.klass.respond_to?(:autocomplete_attribute) && reflection.macro == :belongs_to
      end
      super(method, options)
    end
  end
end
