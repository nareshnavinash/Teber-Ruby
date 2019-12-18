require "uri"
require 'httparty'

module Libraries
  class Api
      def self.get(url, options={})
        begin
            JSON.parse(HTTParty.get(url,options))
        rescue Exception => e
            puts "Unable to complete a get call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
          raise RuntimeError, "Unable to complete a get call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
        end
      end

      def self.post(url, options={})
        begin
          JSON.parse(HTTParty.post(url,options))
        rescue Exception => e
            puts "Unable to complete a post call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
          raise RuntimeError, "Unable to complete a post call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
        end
      end

      def self.put(url,options={})
        begin
            JSON.parse(HTTParty.put(url,options))
        rescue Exception => e
            puts "Unable to complete a put call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
          raise RuntimeError, "Unable to complete a put call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
        end
      end

      def self.patch(url,options={})
        begin
            JSON.parse(HTTParty.patch(url,options))
        rescue Exception => e
            puts "Unable to complete a patch call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
          raise RuntimeError, "Unable to complete a patch call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
        end
      end

      def self.delete(url,options={})
        begin
            JSON.parse(HTTParty.delete(url,options))
        rescue Exception => e
          puts "Unable to complete a delete call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
          raise RuntimeError, "Unable to complete a delete call with URL: #{url} \n\n and Api attributes: #{options} \n\n And FAILED due to : #{e.message} \n\n"
        end
      end

  end
end