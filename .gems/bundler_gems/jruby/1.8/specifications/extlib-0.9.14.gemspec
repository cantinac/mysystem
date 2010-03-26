# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{extlib}
  s.version = "0.9.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Kubb"]
  s.date = %q{2009-12-11}
  s.description = %q{Support library for DataMapper and Merb}
  s.email = %q{dan.kubb@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".autotest", ".document", ".gitignore", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "extlib.gemspec", "lib/extlib.rb", "lib/extlib/array.rb", "lib/extlib/assertions.rb", "lib/extlib/blank.rb", "lib/extlib/boolean.rb", "lib/extlib/byte_array.rb", "lib/extlib/class.rb", "lib/extlib/datetime.rb", "lib/extlib/dictionary.rb", "lib/extlib/hash.rb", "lib/extlib/hook.rb", "lib/extlib/inflection.rb", "lib/extlib/lazy_array.rb", "lib/extlib/lazy_module.rb", "lib/extlib/logger.rb", "lib/extlib/mash.rb", "lib/extlib/module.rb", "lib/extlib/nil.rb", "lib/extlib/numeric.rb", "lib/extlib/object.rb", "lib/extlib/object_space.rb", "lib/extlib/pathname.rb", "lib/extlib/pooling.rb", "lib/extlib/rubygems.rb", "lib/extlib/simple_set.rb", "lib/extlib/string.rb", "lib/extlib/struct.rb", "lib/extlib/symbol.rb", "lib/extlib/time.rb", "lib/extlib/virtual_file.rb", "spec/array_spec.rb", "spec/blank_spec.rb", "spec/byte_array_spec.rb", "spec/class_spec.rb", "spec/datetime_spec.rb", "spec/hash_spec.rb", "spec/hook_spec.rb", "spec/inflection/plural_spec.rb", "spec/inflection/singular_spec.rb", "spec/inflection_extras_spec.rb", "spec/lazy_array_spec.rb", "spec/lazy_module_spec.rb", "spec/mash_spec.rb", "spec/module_spec.rb", "spec/object_space_spec.rb", "spec/object_spec.rb", "spec/pooling_spec.rb", "spec/rcov.opts", "spec/simple_set_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/string_spec.rb", "spec/struct_spec.rb", "spec/symbol_spec.rb", "spec/time_spec.rb", "spec/try_call_spec.rb", "spec/try_dup_spec.rb", "spec/virtual_file_spec.rb", "tasks/ci.rake", "tasks/metrics.rake", "tasks/spec.rake", "tasks/yard.rake", "tasks/yardstick.rake"]
  s.homepage = %q{http://github.com/datamapper/extlib}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{extlib}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Support library for DataMapper and Merb}
  s.test_files = ["spec/array_spec.rb", "spec/blank_spec.rb", "spec/byte_array_spec.rb", "spec/class_spec.rb", "spec/datetime_spec.rb", "spec/hash_spec.rb", "spec/hook_spec.rb", "spec/inflection/plural_spec.rb", "spec/inflection/singular_spec.rb", "spec/inflection_extras_spec.rb", "spec/lazy_array_spec.rb", "spec/lazy_module_spec.rb", "spec/mash_spec.rb", "spec/module_spec.rb", "spec/object_space_spec.rb", "spec/object_spec.rb", "spec/pooling_spec.rb", "spec/simple_set_spec.rb", "spec/spec_helper.rb", "spec/string_spec.rb", "spec/struct_spec.rb", "spec/symbol_spec.rb", "spec/time_spec.rb", "spec/try_call_spec.rb", "spec/try_dup_spec.rb", "spec/virtual_file_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<json_pure>, ["~> 1.2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.2.9"])
      s.add_development_dependency(%q<yard>, ["~> 0.4.0"])
    else
      s.add_dependency(%q<json_pure>, ["~> 1.2.0"])
      s.add_dependency(%q<rspec>, ["~> 1.2.9"])
      s.add_dependency(%q<yard>, ["~> 0.4.0"])
    end
  else
    s.add_dependency(%q<json_pure>, ["~> 1.2.0"])
    s.add_dependency(%q<rspec>, ["~> 1.2.9"])
    s.add_dependency(%q<yard>, ["~> 0.4.0"])
  end
end
