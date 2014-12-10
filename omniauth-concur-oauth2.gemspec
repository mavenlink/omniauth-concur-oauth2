$:.push File.expand_path("../lib", __FILE__)
require 'omniauth-concur-oauth2/version'

Gem::Specification.new do |s|
  s.name = 'omniauth-concur-oauth2'
  s.version = OmniAuth::Concur::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2014-08-07'
  s.authors = ['Adam Scott']
  s.email = 'ascot21@gmail.com'
  s.homepage = 'http://github.com/ascot21/omniauth-concur-oauth2'
  s.summary = %Q{OmniAuth strategy for authenticating with Concur's OAuth2 API}
  s.description = s.summary
  s.license = "The MIT License (MIT)"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activesupport', '~> 4.0'
  s.add_dependency 'omniauth-oauth2', '~> 1.1'
end

