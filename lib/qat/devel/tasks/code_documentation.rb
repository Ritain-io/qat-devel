require 'rake'
require 'kramdown'
require 'yard'
require 'yard/rake/yardoc_task'
require 'open3'

namespace :qat do
  namespace :devel do

    desc 'Run yard documentation checks'
    task :validate_yard_doc, :project do |_, params|
      options = [
        '--no-cache',
        '--no-private',
        '--no-api',
        '--default-return void',
        '--hide-void-return',
        '--verbose',
        '--debug',
        "--title #{params[:project]}"
      ].join(' ')
      cmd     = "yard doc #{options}"

      stdout_str, _stderr_str, status = Open3.capture3(cmd)
      exit_code                       = status.to_s.match(/exit\s(\d+)/).captures.first.to_i
      fail 'Generating docs failed' unless exit_code == 0
      stdout, _, _ = Open3.capture3("yard stats --list-undoc")
      # Match if <100% documented is found in output
      if stdout_str.match(/^\s*100\.00% documented/)
        puts stdout
      else
        fail "The project is not fully documented!\n\n#{stdout}"
      end
    end

  end
end