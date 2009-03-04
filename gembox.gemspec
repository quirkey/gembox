# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gembox}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["FIXME full name"]
  s.date = %q{2009-03-04}
  s.default_executable = %q{gembox}
  s.description = %q{Gembox is a little sinatra app that ties in with your local ruby gems to let you browse and learn more about them.  Please see the project home page for a full description:  http://code.quirkey.com/gembox}
  s.email = ["FIXME email"]
  s.executables = ["gembox"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "VERSION.yml", "bin/gembox", "gembox.gemspec", "lib/extensions.rb", "lib/gembox.rb", "lib/gembox/app.rb", "lib/gembox/config.ru", "lib/gembox/gem_list.rb", "lib/gembox/gems.rb", "lib/gembox/view_helpers.rb", "public/images/edit.png", "public/images/folder.png", "public/images/git.gif", "public/images/page.png", "public/images/page_white_text.png", "public/images/rubygems-125x125t.png", "public/javascripts/base.js", "public/javascripts/jquery.form.js", "public/javascripts/jquery.js", "public/javascripts/jquery.metadata.js", "public/javascripts/jquery.ui.js", "public/swf/clippy.swf", "test/.bacon", "test/test_gembox_app.rb", "test/test_gembox_gems.rb", "test/test_helper.rb", "views/file_tree.haml", "views/gem.haml", "views/gembox.sass", "views/gems_columns.haml", "views/gems_header.haml", "views/gems_table.haml", "views/index.haml", "views/layout.haml", "views/no_results.haml"]
  s.has_rdoc = true
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gembox}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Gembox is a little sinatra app that ties in with your local ruby gems to let you browse and learn more about them}
  s.test_files = ["test/test_gembox_app.rb", "test/test_gembox_gems.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
