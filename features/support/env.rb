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

include AllureCucumber::DSL
include Libraries

if File.exist?('features/global-data/global.yml')
    $conf =  YAML.load_file('features/global-data/global.yml')
else
    puts "features/global-data/global.yml is not found !!!"
end

AllureCucumber::configure do |c|
    c.output_dir = "reports/allure"
    c.clean_dir  = false
end

Cucumber::Core::Test::Step.module_eval do
    def name
        return text if self.text == 'Before hook'
        return text if self.text == 'After hook'
        "#{source.last.keyword}#{text}"
    end
end
