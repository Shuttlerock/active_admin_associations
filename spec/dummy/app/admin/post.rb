require_relative '../../app/models/post'

ActiveAdmin.register ::Post do
  association_actions

  form partial: 'admin/shared/form'

  form_columns :title, :body, :creator

  active_association_form do |f|
    f.inputs class: 'more-inputs' do
      f.input :published_at, input_html: { class: 'my-date-picker' }, as: :string
      f.input :featured
    end
  end

  form_associations do
    association :tags do
      fields :name
    end
  end
end
