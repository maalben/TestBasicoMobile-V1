# frozen_string_literal: true

@driver = $driver
wait = Selenium::WebDriver::Wait.new(timeout: 10)

def ios?
  @driver.caps[:platformName].to_s.downcase == 'ios'
end

Given('the user is on the login page') do
  # Aquí puedes usar cualquier elemento visible para confirmar que la app se abrió
  sleep 5  # Espera para asegurarte de que la app esté completamente cargada
end

When('the user enters {string} into the username field') do |username|
  username_field = wait.until do
    if ios?
      @driver.find_element(:accessibility_id, 'test-Username')
    else
      @driver.find_element(:xpath, '//android.widget.EditText[@content-desc="test-Username"]')
    end
  end
  username_field.send_keys(username)
end

And('the user enters {string} into the password field') do |password|
  password_field = if ios?
                     @driver.find_element(:accessibility_id, 'test-Password')
                   else
                     @driver.find_element(:xpath, '//android.widget.EditText[@content-desc="test-Password"]')
                   end
  password_field.send_keys(password)
end

And('the user clicks the login button') do
  login_button = if ios?
                   @driver.find_element(:accessibility_id, 'test-LOGIN')
                 else
                   @driver.find_element(:xpath, '//android.view.ViewGroup[@content-desc="test-LOGIN"]')
                 end
  login_button.click
end

Then('the user should see the home page') do
  home_page_element = wait.until do
    if ios?
      @driver.find_element(:accessibility_id, 'test-Cart drop zone')
    else
      @driver.find_element(:xpath, '//*[@content-desc="test-Cart drop zone"]')
    end
  end
  expect(home_page_element.displayed?).to be true
end