# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gembox}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Quint"]
  s.date = %q{2009-03-04}
  s.default_executable = %q{gembox}
  s.description = %q{A sinatra based interface for browsing and admiring your gems}
  s.email = %q{aaron@quirkey.com}
  s.executables = ["gembox"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "VERSION.yml", "bin/gembox", "gembox.gemspec", "lib/extensions.rb", "lib/gembox.rb", "lib/gembox/app.rb", "lib/gembox/config.ru", "lib/gembox/gem_list.rb", "lib/gembox/gems.rb", "lib/gembox/view_helpers.rb", "public/images/edit.png", "public/images/folder.png", "public/images/git.gif", "public/images/page.png", "public/images/page_white_text.png", "public/images/rubygems-125x125t.png", "public/javascripts/base.js", "public/javascripts/jquery.form.js", "public/javascripts/jquery.js", "public/javascripts/jquery.metadata.js", "public/javascripts/jquery.ui.js", "public/swf/clippy.swf", "test/.bacon", "test/test_gembox_app.rb", "test/test_gembox_gems.rb", "test/test_helper.rb", "views/file_tree.haml", "views/gem.haml", "views/gembox.sass", "views/gems_columns.haml", "views/gems_header.haml", "views/gems_table.haml", "views/index.haml", "views/layout.haml", "views/no_results.haml"]
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
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.2.2"])
      s.add_runtime_dependency(%q<mislav-will_paginate>, [">= 2.3.7"])
    else
      s.add_dependency(%q<sinatra>, [">= 0.9.1"])
      s.add_dependency(%q<activesupport>, [">= 2.2.2"])
      s.add_dependency(%q<mislav-will_paginate>, [">= 2.3.7"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0.9.1"])
    s.add_dependency(%q<activesupport>, [">= 2.2.2"])
    s.add_dependency(%q<mislav-will_paginate>, [">= 2.3.7"])
  end
end
