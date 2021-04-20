$:.push File.expand_path('lib', __dir__)
require 'active_admin_associations/version'

Gem::Specification.new do |s|
  s.name        = 'activeadmin_associations'
  s.version     = ActiveAdminAssociations::VERSION
  s.authors     = ['Brian Landau']
  s.email       = ['brian.landau@viget.com']
  s.homepage    = 'http://github.com/vigetlabs/active_admin_associations'
  s.summary     = 'This extends ActiveAdmin to allow for better editing of associations.'
  s.description = 'This extends ActiveAdmin to allow for better editing of associations.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.extra_rdoc_files = ['README.md', 'MIT_LICENSE.txt']

  s.add_dependency 'activeadmin', '~> 2.9.0'
  s.add_dependency 'rails', '~> 6.0'

  s.add_development_dependency 'appraisal', '~> 2.4'
  s.add_development_dependency 'capybara', '~> 3.35'
  s.add_development_dependency 'coveralls', '~> 0.8'
  s.add_development_dependency 'database_cleaner', '~> 2.0'
  s.add_development_dependency 'factory_bot_rails', '~> 6.1'
  s.add_development_dependency 'rails-controller-testing', '~> 1.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec-rails', '~> 4.0'
  s.add_development_dependency 'rubocop', '~> 1.12'
  s.add_development_dependency 'rubocop-performance', '~> 1.10'
  s.add_development_dependency 'rubocop-rails', '~> 2.9'
  s.add_development_dependency 'rubocop-rspec', '~> 2.2'
  s.add_development_dependency 'shoulda-matchers', '~> 4.5'
end
