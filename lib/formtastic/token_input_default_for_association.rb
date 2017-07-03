module Formtastic
  module TokenInputDefaultForAssociation
    extend ActiveSupport::Concern

    def default_input_type(method, options = {})
      if @object
        reflection = reflection_for(method)
        if reflection && reflection.klass.respond_to?(:autocomplete_attribute) && reflection.macro == :belongs_to
          return :token
        end
      end
      super(method, options)
    end
  end
end
