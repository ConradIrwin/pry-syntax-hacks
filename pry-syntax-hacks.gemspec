Gem::Specification.new do |s|
  s.name = "pry-syntax-hacks"
  s.version = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.author = "Conrad Irwin"
  s.email = "conrad.irwin@gmail.com"
  s.homepage = "http://github.com/ConradIrwin/pry-syntax-hacks"
  s.summary = "Allows various short-cuts that make exploring Ruby objects nicer"
  s.description = "Allows you to do object.@instance_var, or object.!private_method(:args), or foo.map &object.:method_name"
  s.files = ["lib/pry-syntax-hacks.rb", "README.markdown", "LICENSE.MIT"]
  s.require_path = "lib"
  s.add_dependency 'pry'
end
