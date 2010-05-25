require "rubygems"
gem "rspec"
gem "selenium-client"
require "selenium/client"
require "selenium/rspec/spec_helper"

describe "MySystem" do
  attr_reader :selenium_driver
  alias :page :selenium_driver

  before(:all) do
    @this_dir = File.dirname(__FILE__)
    @test_dir = File.expand_path("#{@this_dir}/../test/")
    @base_dir = File.expand_path("#{@this_dir}/../")
    @page_screenshot_dir = "#{@this_dir}/tmp/screenshots/#{Time.now.to_i}"
    @base_url = "http://localhost/mysystem/mysystem/" #@base_url = "file://#{@base_dir}"
    @verification_errors = []
    @selenium_driver = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*firefox",
      :url => @base_url, #"file://#{@base_dir}",
      :timeout_in_second => 60
  end

  before(:each) do
    puts "basedir: #{@base_dir}<br/>\b"
    @selenium_driver.start_new_browser_session
  end 
  
  append_after(:each) do
    @selenium_driver.close_current_browser_session
    @verification_errors.should == []
  end
  

  it "should not let me navigate backwards using the backspace or delete key" do
    #pending "This test works fine in the browser when run by hand ..."
    page.open "#{@base_url}/src/blank.html"
    page.click "link=click here"
    page.wait_for_page_to_load "30000"
    page.click "id=center"
    
    #delete
    page.key_press "id=center", "\\127"
    page.get_title.should == "MySystem-dev"
    
    #backspace
    page.key_press "id=center", "\\8"
    page.get_title.should == "MySystem-dev"
  end
  
  it "should let me type backspaces into form fields" do
    #pending "This test works fine in the browser when run by hand ..."
    page.open "#{@base_url}/src/mysystem-dev.html" 
    page.drag_and_drop "//div[@id='left']/div[1]/img[1]", "+300,+0"
    page.mouse_down_at "//*[@id=\"center\"]/div/div[1]/div[1]", "30,15"
    page.mouse_up_at "//*[@id=\"center\"]/div/div[1]/div[1]", "30,15"
    page.type "name", "namex"
    page.get_value("name").should == "namex"
    page.key_press "id=name", "\\8"
    page.get_value("name").should == "name"
  end
  
  it "should look correct to a human when rendering a pre-defined diagram with Raphael in EDIT mode" do
    # Open the page and wait for five seconds, to ensure all our JS libraries have time to get started
    page.open "#{@base_url}/src/mysystem-dev.html"
    page.set_speed 5000
    
    # Paths to output files
    html_path = "#{@page_screenshot_dir}/raphael_edit_mode.html"
    image_path = "#{@page_screenshot_dir}/gfx/raphael_edit_mode.png"
    
    # Produce the raw data for our screenshot
    encoded_image = page.capture_entire_page_screenshot_to_string("")
    png_image = Base64.decode64(encoded_image)
    
    # Write our image file to disk. We don't want to create the directories until now, so we don't
    # wind up with empty directories in case of an image capture failure
    FileUtils.mkdir_p(File.dirname(image_path))
    File.open(image_path, "wb") { |f| f.write png_image }
    
    # Write our little HTML wrapper page
    caption = "test caption"
    html = <<EOT
<html>
  <head>
    <title>MySystem Edit Mode Acceptance Test :: #{caption}</title>
  </head>
  <body>
    <center>
      <img src="gfx/raphael_edit_mode.png" />
      <p>#{caption}</p>
    </center>
  </body>
</html>
EOT
    File.open(html_path, "w") { |f| f.write html }
    
    # Set Selenium command speed back to default
    page.set_speed 0
  end
  
  it "should look correct to a human when rendering a pre-defined diagram with Raphael in PRINT mode" do
    # Open the page and wait for five seconds, to ensure all our JS libraries have time to get started
    page.open "#{@base_url}/src/print.html"
    page.set_speed 5000
    
    # Paths to output files
    html_path = "#{@page_screenshot_dir}/raphael_print_mode.html"
    image_path = "#{@page_screenshot_dir}/gfx/raphael_print_mode.png"
    
    # Produce the raw data for our screenshot
    encoded_image = page.capture_entire_page_screenshot_to_string("")
    png_image = Base64.decode64(encoded_image)
    
    # Write our image file to disk. We don't want to create the directories until now, so we don't
    # wind up with empty directories in case of an image capture failure
    FileUtils.mkdir_p(File.dirname(image_path))
    File.open(image_path, "wb") { |f| f.write png_image }
    
    # Write our little HTML wrapper page
    caption = "test caption"
    html = <<EOT
<html>
  <head>
    <title>MySystem Print Mode Acceptance Test :: #{caption}</title>
  </head>
  <body>
    <center>
      <img src="gfx/raphael_print_mode.png" />
      <p>#{caption}</p>
    </center>
  </body>
</html>
EOT
    File.open(html_path, "w") { |f| f.write html }
    
    # Set Selenium command speed back to default
    page.set_speed 0
  end
end
