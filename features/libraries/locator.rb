module Libraries
    class Locator
        attr_accessor :how
        attr_accessor :what
        attr_accessor :options

        def initialize(
                        how,
                        what,
                        options = {
                        "hidden" => false,
                        "ajax_load" => false,
                        })
        @how = how
        @what = what
        @options = options
        end

        def flash(driver = $focus_driver)
            element = driver.find_element(self)
            attr = element.attribute("backgroundColor")
            driver.execute_script "arguments[0].style.backgroundColor = 'red';", element
            sleep 0.1
            driver.execute_script "arguments[0].style.backgroundColor = arguments[1];", element, attr
            sleep 0.1
            driver.execute_script "arguments[0].style.backgroundColor = 'red';", element
            sleep 0.1
            driver.execute_script "arguments[0].style.backgroundColor = arguments[1];", element, attr
        end

        ##################################################
        # Methods inherited and overriden from Selenium  #
        ##################################################

        def self.mouse_over(element, driver = $focus_driver)
            driver.action.move_to(element).perform
        end

        def click(driver = $focus_driver)
            begin
                driver.find_element(self).click
                puts "Clicked - #{self.how} => #{self.what}"
            rescue Exception => e
                puts "Not clicked at - #{self.how} => #{self.what}"
                puts e.message
            end
        end

        def text(driver = $focus_driver)
            return driver.find_element(self).text
        end

        def texts(driver = $focus_driver)
            elements_text = []
            driver.find_elements(self).each do |element|
                elements_text.push(element.text)
            end
            return elements_text
        end

        def attribute(name, driver = $focus_driver)
            driver.find_element(self).attribute(name)
        end

        def css_value(prop, driver = $focus_driver)
            driver.find_element(self).css_value(prop)
        end

        def displayed?(driver = $focus_driver)
            driver.find_element(self).displayed?
        end

        def enabled?(driver = $focus_driver)
            driver.find_element(self).enabled?
        end

        def is_enabled_with_wait?(timeout = $conf["implicit_wait"], driver = $focus_driver)
            index = 0
            while driver.find_element(self).enabled? == false
                sleep 1
                break if index == timeout
                index += 1
            end
        end

        def hash(driver = $focus_driver)
            driver.find_element(self).hash
        end

        def location(driver = $focus_driver)
            driver.find_element(self).location
        end

        def location_once_scrolled_into_view(driver = $focus_driver)
            driver.find_element(self).location_once_scrolled_into_view
        end

        def property(driver = $focus_driver)
            driver.find_element(self).property
        end

        def selected?(driver = $focus_driver)
            driver.find_element(self).selected?
        end

        def size(driver = $focus_driver)
            driver.find_element(self).size
        end

        def style(prop, driver = $focus_driver)
            driver.find_element(self).style(prop)
        end

        def submit(driver = $focus_driver)
            driver.find_element(self).submit
        end

        def count(driver = $focus_driver)
            element_list = driver.find_elements(self)
            return element_list.count
        end

        def select_drop_down_based_on_text(driver = $focus_driver, option_text)
            driver.find_element(self).find_elements(tag_name: "option").each { |option| option.click if option.text == option_text }
        end

        def select_drop_down_based_on_partial_text(driver = $focus_driver, option_text)
            driver.find_element(self).find_elements(tag_name: "option").each { |option| option.click if option.text.include? option_text }
        end

        def select_drop_down_based_on_option_count(driver = $focus_driver, option_count)
            css_for_option = option[value = "#{option_count}"]
            driver.find_element(self).find_element(:css, "#{css_for_option}").click
        end

        def tag_name(driver = $focus_driver)
            driver.find_element(self).tag_name
        end

        def is_present?(driver = $focus_driver)
            driver.driver.manage.timeouts.implicit_wait = 0
            begin
                return driver.driver.find_element(self.how, self.what).displayed?
            rescue Exception => e
                driver.driver.manage.timeouts.implicit_wait = $conf["implicit_wait"]
                return false
            ensure
                driver.driver.manage.timeouts.implicit_wait = $conf["implicit_wait"]
            end
        end

        def is_not_present?(driver = $focus_driver)
            return !is_present?(driver)
        end

        def is_present_with_wait?(timeout = $conf["implicit_wait"], driver = $focus_driver)
            Wait.wait_for_element(self, timeout, driver)
            is_present?(driver)
        end

        def is_not_present_with_wait?(timeout = $conf["implicit_wait"], driver = $focus_driver)
            Wait.wait_for_element_hide(self, timeout, driver)
            return !is_present?(driver)
        end

        def click_if_present(driver = $focus_driver)
            click(driver) if is_present?(driver)
        end

        def scroll_to_locator(driver = $focus_driver)
            $focus_driver.scroll_to_locator(self)
        end

        def click_if_present_with_wait(timeout = $conf["implicit_wait"], driver = $focus_driver)
            click(driver) if is_present_with_wait?(timeout, driver)
        end

        def to_s
            return "How ===> #{@how}\nWhat ===> #{@what}\nOptions ===> #{@options}"
        end

        def mouse_over(index = 1, driver = $focus_driver)
            element = driver.find_elements(self)[index - 1]
            driver.action.move_to(element).perform
        end

        def move_and_click(driver = $focus_driver)
            element = driver.find_element(self)
            driver.action.move_to(element).click.perform
        end

        def get_element(driver = $focus_driver)
            driver.find_element(self)
        end

        ################################
        # Check box methods
        ################################

        def is_checked?(driver = $focus_driver)
            self.attribute("checked") == "true"
        end

        def check(driver = $focus_driver)
            self.click unless self.is_checked?
        end

        def uncheck(driver = $focus_driver)
            self.click if self.is_checked?
        end

        ##############################
        # Text box methods
        ##############################

        def clear(driver = $focus_driver)
            driver.find_element(self).clear
        end

        def send_keys(*args)
            $focus_driver.find_element(self).send_keys(*args)
        end

        def clear_and_send_keys(*args)
            clear($focus_driver)
            send_keys(*args)
        end

        def get_value(driver = $focus_driver)
            driver.find_element(self).attribute("value")
        end
    end
end
