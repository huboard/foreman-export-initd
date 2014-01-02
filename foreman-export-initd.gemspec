Gem::Specification.new do |gem|
  gem.name    = 'foreman-export-initd'
  gem.version = '0.0.7'

  gem.add_dependency 'foreman', '>= 0.59.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '>= 2.0'
  gem.add_development_dependency 'fakefs', '>= 0.4.3'

  gem.summary = 'init.d export scripts for foreman'
  gem.description = 'init.d export scripts for foreman'

  gem.authors  = ['Tomasz Durka', 'Cargo Media']
  gem.email    = 'tomasz.durka@cargomedia.ch'
  gem.homepage = 'http://github.com/cargomedia/foreman-export-initd'

  gem.has_rdoc = false
  gem.extra_rdoc_files = %w(README.md)

  gem.files = Dir['{bin,lib,templates}/**/*', 'README*', 'LICENSE*']
end
