Gem::Specification.new do |gem|
  gem.name        = "capistrano-db-mirror"
  gem.version     = ::File.read(::File.expand_path('../VERSION', __FILE__)).to_s.strip
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Daisuke Taniwaki"]
  gem.email       = ["daisuketaniwaki@gmail.com"]
  gem.homepage    = "https://github.com/kaizenplatform/capistrano-db-mirror"
  gem.summary     = "Mirror DB from Remote"
  gem.description = "Mirror DB from Remote"
  gem.license     = "MIT"

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "capistrano", ">= 3.0"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 3.0"
end
