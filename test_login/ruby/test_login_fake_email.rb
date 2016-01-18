require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class TestLoginFakeEmail < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://staging.88em.eu/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_login_fake_email
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Zaloguj się").click
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys "nobody@88em.eu"
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys "8Hekddr8"
    @driver.find_element(:id, "submit").click
    verify { assert_equal "Podaj prawidłowy adres email i hasło.", @driver.find_element(:css, "span.label.label-danger").text }
  end
  
  def element_present?(how, what)
    ${receiver}.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    ${receiver}.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = ${receiver}.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
