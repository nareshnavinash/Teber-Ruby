Before('@TC_Google_Search') do
  $filter_run_once ||= false  # have to define a variable before we can reference its value
  if !$filter_run_once
    @@driver = Driver.new()
    @@google_page = Pages::GoogleSearch.new
  end
  $filter_run_once = true
end

Before('@TC_Google_Search') do
  
end

Given("I navigate to google search page") do
    @@driver.get("https://www.google.com")
end

When("I type the term in google search bar and click on serach results") do
    @@google_page.enter_text_and_search("Hello")
end

Then("I should get the results page") do
    expect(@@google_page.is_results_page_displayed?).to eql true
end

When("I type the {string} in google search bar and click on serach results") do |string|
    @@google_page.enter_text_and_search(string)
end