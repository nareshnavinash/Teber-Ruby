module Locators
    class GoogleSearch
  
      attr_reader :SEARCH_BOX
      attr_reader :SEARCH_BUTTON
      attr_reader :AFTER_SEARCH_IMAGE
      
      def initialize
  
        @SEARCH_BOX = Locator.new(:name, "q")
        @SEARCH_BUTTON = Locator.new(:css, "input[name='btnK']")
        @AFTER_SEARCH_IMAGE = Locator.new(:css, "div.logo img[alt*='Google']")

      end
  
    end
  end
  