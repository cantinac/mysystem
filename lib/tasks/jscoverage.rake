namespace :jscoverage do
  desc "Generate files to test coverage of src files (requires jscoverage to be installed)"
  task :src do
    %x(jscoverage src/ instrumented/)
  end
  desc "Generate files to test coverage of public files (requires jscoverage to be installed)"
  task :public do
    Rake::Task["combine:all"].reenable
    Rake::Task["combine:all"].invoke
    %x(jscoverage public/ instrumented/)
  end
end