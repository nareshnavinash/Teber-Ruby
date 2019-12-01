module Pages
    class GoogleSearch < Locators::GoogleSearch
  
      def initialize
        super()
      end
  
      def enter_text_and_search(string)
        @SEARCH_BOX.is_present_with_wait?
        @SEARCH_BOX.clear_and_send_keys(string)
        @SEARCH_BUTTON.scroll_to_locator
        @SEARCH_BUTTON.move_and_click
      end

      def is_results_page_displayed?
        @AFTER_SEARCH_IMAGE.is_present_with_wait?
      end

    end
  end
  