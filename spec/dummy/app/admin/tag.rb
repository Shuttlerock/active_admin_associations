require_relative '../../app/models/tag'

ActiveAdmin.register Tag do
  association_actions

  form partial: 'admin/shared/form'

  form_columns :name

  form_associations do
    association :posts, %i[title creator]
  end
end
