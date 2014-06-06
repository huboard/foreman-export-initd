Gem::Specification.new do |gem|
  gem.name        = 'foreman-export-initd'
  gem.version     = '0.1.1'
  gem.summary     = 'init.d export scripts for foreman'
  gem.description = 'Foreman-exporter to create init.d- and monit-scripts'
  gem.authors     = ['Cargo Media', 'Tomasz Durka']
  gem.email       = 'tomasz.durka@cargomedia.ch'
  gem.files       = Dir['LICENSE*', 'README*', '{bin,lib,templates}/**/*']
  gem.homepage    = 'http://github.com/cargomedia/foreman-export-initd'
  gem.license     = 'MIT'

  gem.has_rdoc = false
  gem.extra_rdoc_files = %w(README.md)

  gem.add_dependency 'foreman', '>= 0.59.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '>= 2.0'
  gem.add_development_dependency 'fakefs', '>= 0.4.3'
end
