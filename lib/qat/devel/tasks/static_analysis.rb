require 'rake'
require 'fileutils'
require 'json'

namespace :qat do
  namespace :devel do
    namespace :static_analysis do

      desc 'Generate report HTML'
      task :html do
        %x(rubycritic --no-browser -p test/public/rubycritic lib)
      end

      desc 'Genarate report JSON'
      task :json do
        FileUtils.mkdir_p 'test/public/rubycritic'
        %x(rubycritic -f json -p test/public/rubycritic lib)
      end

      desc "Validation of RubyCritic static analysis for a given minimum rating (default is 'B')"
      task :validation, :rating do |_, params|
        rating    = params[:rating] || 'B'
        json_path = 'test/public/rubycritic/report.json'
        Rake::Task['qat:devel:static_analysis:json'].invoke

        data_hash    = JSON.parse(File.read(json_path))
        module_array = data_hash['analysed_modules']

        bad_modules = module_array.select do |module_analysis|
          module_analysis['rating'] > rating
        end
        if bad_modules.empty?
          puts "Ratings OK!"
        else
          report = bad_modules.map { |bad_module| "#{bad_module['name']}\t\t#{bad_module['rating']}" }
          fail "There are ratings under '#{rating}'.\n\n Modules:\n#{report.join("\n")}"
        end
      end
    end
  end
end