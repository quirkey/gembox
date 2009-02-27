# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gembox}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Quint"]
  s.date = %q{2009-02-27}
  s.default_executable = %q{gembox}
  s.description = %q{A sinatra based interface for browsing and admiring your gems}
  s.email = %q{aaron@quirkey.com}
  s.executables = ["gembox"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "VERSION.yml", "bin/gembox", "lib/extensions.rb", "lib/gembox", "lib/gembox/app.rb", "lib/gembox/gem_list.rb", "lib/gembox/gems.rb", "lib/gembox/view_helpers.rb", "lib/gembox.rb", "test/test_gembox_app.rb", "test/test_gembox_gems.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/quirkey/gembox}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A sinatra based interface for browsing and admiring your gems.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubygems>, [">= 1.3.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.2.2"])
      s.add_runtime_dependency(%q<mislav-will_paginate>, [">= 2.3.7"])
    else
      s.add_dependency(%q<rubygems>, [">= 1.3.1"])
      s.add_dependency(%q<activesupport>, [">= 2.2.2"])
      s.add_dependency(%q<mislav-will_paginate>, [">= 2.3.7"])
    end
  else
    s.add_dependency(%q<rubygems>, [">= 1.3.1"])
    s.add_dependency(%q<activesupport>, [">= 2.2.2"])
    s.add_dependency(%q<mislav-will_paginate>, [">= 2.3.7"])
  end
end
