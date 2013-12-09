Gem::Specification.new do |gem|
  gem.name    = 'foreman-export-initd'
  gem.version = '0.0.1'
  gem.date    = Date.today.to_s

  gem.add_dependency 'foreman', '>= 0.59.0'

  gem.summary = "init.d export scripts for foreman"
  gem.description = "init.d export scripts for foreman"

  gem.authors  = ['Tomasz Durka', 'Cargomedia']
  gem.email    = 'tomasz@durka.pl'
  gem.homepage = 'http://github.com/tomaszdurka/foreman-export-initd'

  gem.has_rdoc = false
  gem.extra_rdoc_files = ['README.md']

  gem.files = Dir['{bin,lib,data}/**/*', 'README.md']

  gem.executables = "foreman-initd"
end