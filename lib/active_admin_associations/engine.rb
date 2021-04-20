module ActiveAdminAssociations
  class Engine < Rails::Engine
    config.activeadmin_associations = ActiveSupport::OrderedOptions.new

    initializer 'active_admin_associations.load_extensions' do |app|
      ActiveAdmin::BaseController.helper ActiveAdminAssociationsHelper
      ActiveAdmin::ResourceDSL.include ActiveAdminAssociations::AssociationActions
      ActiveAdmin::ResourceDSL.include ActiveAdminAssociations::FormConfigDSL

      unless app.config.activeadmin_associations.destroy_redirect == false
        ActiveAdmin::BaseController.include ActiveAdminAssociations::RedirectDestroyActions
      end

      unless app.config.activeadmin_associations.autocomplete == false
        ActiveSupport.on_load(:active_record) do
          ActiveRecord::Base.include ActiveAdminAssociations::Autocompleter
        end

        Formtastic::FormBuilder.include Formtastic::TokenInputDefaultForAssociation
      end
    end
  end
end
