require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'rspec'

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include LoginHelper
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.after(:each) do |example|
    if example.exception
      time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      filename = "screenshots/#{time}_#{example.description.gsub(' ', '_')}.png"
      page.save_screenshot(filename)
    end
  end
end

Capybara.configure do |config|
  config.default_driver = :selenium_chrome
  config.app_host = 'https://www.saucedemo.com'
  config.default_max_wait_time = 10
end

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end