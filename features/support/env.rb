require 'allure-cucumber'
require 'webdriver_manager'
require 'cucumber'
require 'require_all'
require 'pathname'
require 'fileutils'
require "pry"
require 'pry-remote'
require_rel "../locators/"
require_rel "../libraries/"
require_rel "../pages/"
require "time"
require 'faker'
require 'git'
require 'rest-client'
require 'json'
require 'parallel_tests'
require 'teber'

include AllureCucumber::DSL
# include Teber
include Libraries
$VERBOSE = nil

if File.exist?('features/global-data/global.yml')
    $conf =  YAML.load_file('features/global-data/global.yml')
else
    puts "features/global-data/global.yml is not found !!!"
end

AllureCucumber::configure do |c|
    c.output_dir = "reports/allure"
    c.clean_dir  = true
end

Cucumber::Core::Test::Step.module_eval do
    def name
        return text if self.text == 'Before hook'
        return text if self.text == 'After hook'
        "#{source.last.keyword}#{text}"
    end
end

Before do |scenario|
    # Have the test data corresponding to a feature in the path `/features/test-data/` in the .conf format
    # Name the file as same as the feature file and the below code will parse that file and have the variables in $param
    # Test data specific to that feature can be accessed with $param in that step definition file.
    feature = scenario.location
    feature_file_name = feature.to_s.rpartition('/').last.split('.feature')[0]
    test_variables_file_location = Dir.pwd + "/features/test-data/#{feature_file_name}.yml"
    if File.exists?("#{test_variables_file_location}")
      $param = YAML.load_file(test_variables_file_location)
    end
end
  
After do |scenario|
    if scenario.failed?
        begin
            drivers = Driver.get_all_drivers
            drivers.each do |l,m|
              Driver.switch_to(l)
              scenario.attach_file(m,l.save_screenshot)
            end
        rescue Exception => e
            puts e.message
            puts e.backtrace
        end
        # to quit the test run if any one of the scenario is failed
    end
end
  
  
at_exit do
    # Moving the categories.json file from libraries to the allure folder
    # rerun results are not shown with the categories in allure report.
    # Raised an issue with allure-cucumber https://github.com/allure-framework/allure-cucumber/issues/83
    if ParallelTests.first_process?
        ParallelTests.wait_for_other_processes_to_finish
    end
    source_directory      = Dir.pwd + "/features/libraries/categories.json"
    destination_directory = Dir.pwd + "/reports/allure/"
    `cp -a #{source_directory} #{destination_directory}`
end