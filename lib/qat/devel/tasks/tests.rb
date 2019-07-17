require 'cucumber'
require 'cucumber/rake/task'

namespace :qat do
  namespace :devel do
    namespace :tests do

      def load_dependencies(task)
        task.libs << File.join(Dir.pwd, '..', 'lib')
      end

      def clear_public_folder!
        mkdir_p 'public'
        rm_rf Dir.glob(File.join('public', '*'))
      end

      desc 'Run all the tests'
      task :run do
        cd 'test' do
          Cucumber::Rake::Task.new do |task|
            load_dependencies(task)
            clear_public_folder!
          end.runner.run
        end
      end

    end
  end
end
