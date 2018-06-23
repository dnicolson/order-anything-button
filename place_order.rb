require 'selenium-webdriver'
require 'headless'

@headless = Headless.new
@headless.start
@driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)


#Go to the Landing Page

 	puts "Logging in..."
 	@driver.get ENV["AMAZON_PRODUCT_LINK"]
 	wait

 	quantity = @driver.find_element(:id, "quantity")
 	options = quantity.find_elements(tag_name: "option")
 	options.each do |el|
     	if (el.attribute("value") == ENV["AMAZON_PRODUCT_QUANTITY"])
         	el.click()
         	break
     	end
 	end

 	button = @driver.find_element(:id, "add-to-cart-button")
 	button.click
 	wait

 	button = @driver.find_element(:id, "hlb-ptc-btn-native")
 	button.click
 	wait

#Sign in
	email = @driver.find_element(:xpath, ".//*[@id='ap_email']")
	email.send_keys(ENV["AMAZON_EMAIL"])
	wait

	button = @driver.find_element(:id, "continue")
	button.click
	wait

	password = @driver.find_element(:name, "password")
	password.send_keys(ENV['AMAZON_PASSWORD'])
	wait

	button = @driver.find_element(:id, "signInSubmit")
	button.click
	wait

	button = @driver.find_element(:xpath, ".//a[contains(@href, #{ENV['AMAZON_DELIVERY_ID']})]")
	button.click
	wait

#Check out
	button = @driver.find_element(:xpath, ".//input[@value='Continue']")
	button.click
	wait

	sleep(3)

	button = @driver.find_element(:xpath, ".//input[@value='Continue']")
	button.click
	wait

	sleep(3)

	button = @driver.find_element(:xpath, ".//input[@value='Continue']")
	button.click
	wait

	button = wait.until { @driver.find_element(:name, 'placeYourOrder1') }
	button.click
	puts "Checking out..."
	puts "#{@driver.title}"


puts "Done! Item en route."

@driver.quit
@headless.destroy
