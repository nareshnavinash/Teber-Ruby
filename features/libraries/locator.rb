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

        def selected?(driver = $focus_driver)
            driver.find_element(self).selected?
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

        def click_if_present_with_wait(timeout = $conf["implicit_wait"], driver = $focus_driver)
            click(driver) if is_present_with_wait?(timeout, driver)
        end

        def move_and_click(driver = $focus_driver)
        element = driver.find_element(self)
        driver.action.move_to(element).click.perform
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
