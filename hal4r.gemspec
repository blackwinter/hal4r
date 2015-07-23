# -*- encoding: utf-8 -*-
# stub: hal4r 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "hal4r"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jens Wille"]
  s.date = "2015-07-23"
  s.description = "HAL processing for Ruby."
  s.email = "jens.wille@gmail.com"
  s.executables = ["hal4r"]
  s.extra_rdoc_files = ["README", "COPYING", "ChangeLog"]
  s.files = ["COPYING", "ChangeLog", "README", "Rakefile", "bin/hal4r", "lib/hal4r.rb", "lib/hal4r/matrix.rb", "lib/hal4r/vector.rb", "lib/hal4r/version.rb", "spec/hal4r/matrix_spec.rb", "spec/hal4r/vector_spec.rb", "spec/hal4r_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/blackwinter/hal4r"
  s.licenses = ["AGPL-3.0"]
  s.post_install_message = "\nhal4r-0.0.1 [2015-07-23]:\n\n* First release.\n\n"
  s.rdoc_options = ["--title", "hal4r Application documentation (v0.0.1)", "--charset", "UTF-8", "--line-numbers", "--all", "--main", "README"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.4.8"
  s.summary = "Hyperspace analogue to language for Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rb-gsl>, [">= 0"])
      s.add_development_dependency(%q<hen>, [">= 0.8.1", "~> 0.8"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rb-gsl>, [">= 0"])
      s.add_dependency(%q<hen>, [">= 0.8.1", "~> 0.8"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rb-gsl>, [">= 0"])
    s.add_dependency(%q<hen>, [">= 0.8.1", "~> 0.8"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
