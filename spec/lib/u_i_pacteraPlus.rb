# THIS TEST
# ---------
# This test demonstrates the UI test case for PacteraPlus application
#
#
# run using:
#
# bundle exec rspec u_i_catalog.rb
#
# run only a tagged group:
#
# bundle exec rspec --tag one u_i_catalog.rb
#

require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'



APP_PATH = './PacteraPulse.app'
#appium -U cf2b7df852cafea74095ee487c9191744ef10d39 --app /Users/jin/Desktop/PacteraPulse.ipa
#appium &
def desired_caps
  {
    caps: {
      platformName: 'iOS',
       deviceName:  'iPhone 6',
       versionNumber:  '8.1',
       app: APP_PATH

       # platformName: 'iOS',
       # deviceName:  'iPhone 5s',
       # uuid: 'cf2b7df852cafea74095ee487c9191744ef10d39',
       # app:'/Users/jin/Desktop/PacteraPulse.ipa',
    },
    appium_lib: {
      sauce_username: nil, # don't run on sauce
      sauce_access_key: nil,
      wait: 10
    }
  }
end

describe 'PacteraPulse UI' do
	@error = false
	before(:all) do
    	Appium::Driver.new(desired_caps).start_driver
    	Appium.promote_appium_methods RSpec::Core::ExampleGroup
	end

	def back_click(opts={})
		opts ||= {}
		search_wait = opts.fetch(:wait, 10) # seconds
		wait(search_wait) { button_exact('Back').click }
	end

	def check_error()
		set_wait 1
		alertView = find_elements(:class_name,'UIAAlert')
		if alertView.any?
			find_element(:name, 'OK').click
			@error = true
		else 
			@error = false
		end
	end
	after(:all) do
		driver_quit
	end

	describe 'FirstTime Launch', :one do
		after :all do
			startButton = find_elements(:name, 'Tap to start')
			if startButton.any?
				startButton[0].click
			end
		end

		it "can have a start Page on first launch, otherwise can't be seen", :filePath=> 'screenshot/1.png' do
			startButton = find_elements(:name, 'Tap to start')
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/1.png")
			if startButton.any?
				startButton[0].displayed?.should be true
			else
				startButton[0].should be nil
			end
		end
	end

	describe 'Back to Welcome page' do
		after :all do
			if find_element(:name, 'Tap to start') != nil
				find_element(:name, 'Tap to start').click
			end
		end
		it 'can back to the welcome page',:filePath=> 'screenshot/2.png' do
			find_element(:name, 'Info').click
			startButton = find_element(:name, 'Tap to start')
			startButton.click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/2.png")			
			startButton.displayed?.should be false
		end
	end

	describe 'Employee voting page' do
		after :all do
     		back_click
    	end	

		it 'can be in the voting page' ,:filePath=> 'screenshot/3.png' do
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/3.png")
			votingMainPage = find_element(:class_name, 'UIATableView')
			votingMainPage.should_not be_nil;
		end

		it 'can vote happy emotion',:filePath=> 'screenshot/4.png' do
			find_elements(:class_name, "UIATableCell")[2].click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/4.png")
			check_error
		end

	end

	describe 'Show the result page ' do
		after :all do
     		back_click
    	end
		it 'can click result button' ,:filePath=> 'screenshot/4.png' do
			find_element(:name, 'Share').click
			reusltPage = find_element(:name,'24 Hours Results')
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/4.png")
			check_error
			if !@error
				reusltPage.displayed?.should be true
			else
				reusltPage.displayed?.should be false
			end
		end
	end

	describe 'Vote happy, unHappy, soso' do
		after :all do
     		set_wait 3
    	end
		it 'can click happy button',:filePath=> 'screenshot/5.png'  do
			find_elements(:class_name, "UIATableCell")[2].click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/5.png")
			check_error
			if !@error
				back_click
			end
		end


		it 'can click unHappy button',:filePath=> 'screenshot/6.png'  do
			find_elements(:class_name, "UIATableCell")[1].click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/6.png")
			check_error
			if !@error
				back_click
			end
		end

		it 'can click soso button',:filePath=> 'screenshot/7.png'  do
			find_elements(:class_name, "UIATableCell")[0].click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/7.png")
			check_error
			if !@error
				back_click
			end
		end
	end

end
