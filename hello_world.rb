require 'watir'
require 'pry'
require 'selenium-webdriver'

PROXY = {'14.140.131.82': '3128', '20.219.112.2': '80', '20.204.214.79': '3129', '142.93.223.219': '8080', '68.178.161.181': '80', '49.249.155.3': '80'}

def generate_bitly_session(proxy_ip, proxy_port)
  proxy = Selenium::WebDriver::Proxy.new(
    http: "#{proxy_ip}:#{proxy_port}",
    ssl: "#{proxy_ip}:#{proxy_port}"
  )

  browser = Watir::Browser.new(:chrome, options: { proxy: proxy })

  puts "Give me the origin url"
  url = gets.chomp
  browser.goto("#{url}")

  element = browser.element(rel:"nofollow")
  bitly_url = element.text
  browser.goto bitly_url
  browser.execute_script("window.scrollBy(0, 500)")
end

def invite_user
  PROXY.each do |proxy_ip, proxy_port|
    generate_bitly_session(proxy_ip, proxy_port)
  end
end

invite_user
