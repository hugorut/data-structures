require 'rake/testtask'

test = Rake::TestTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*.rb']
    t.verbose = true
end

desc "Run tests"
task :default => :test
