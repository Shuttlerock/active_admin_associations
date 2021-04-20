module ActiveAdmin
  class Resource
    attr_accessor :form_columns, :form_associations, :active_association_form
  end

  class << self
    def resources
      application.namespaces.map  do |n|
        n.resources.send(:resources)
      end.flatten.compact.select  do |r|
        r.instance_of?(ActiveAdmin::Resource)
      end.map(&:resource_class)
    end
  end
end
