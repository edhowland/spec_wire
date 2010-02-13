require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "spec_wire"
    gem.summary = %Q{spec_wire}
    gem.description = %Q{spec_wire_desc}
    gem.email = "ed.howland@gmail.com"
    gem.homepage = "http://github.com/edhowland/spec_wire"
    gem.authors = ["Ed Howland"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_development_dependency "cucumber", ">= 0"
    gem.add_dependency("json", ">= 1.2.0")
    gem.add_dependency("rest-client", ">= 1.2.0")
    gem.add_dependency("sinatra", ">= 0.9.4")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

namespace "server" do
  desc "Start ruby server for specs"
  task :start do |t|
    system "bin/server.start"
  end
  
  desc "Stop ruby server for specs"
  task :stop do |t|
    system "bin/server.stop"
  end

  desc "Run specs with server"
  task :specs => [:check_dependencies] do |t|
    Rake::Task["server:start"].execute
    Rake::Task[:spec].execute
    Rake::Task["server:stop"].execute
  end
end

namespace "db" do
  desc "[NoOP] Migrate the database through scripts in db/migrate and update db/schema.rb by invoking db:schema:dump. Target specific version with VERSION=x. Turn off output with VERBOSE=false."
  task :migrate do |t|
    puts "Nothing to see here. Move along."
  end
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => "server:specs"

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

# attempt our at_exit, only if server is running
# at_exit do
#   Rake::Task["server:stop"]
# end
