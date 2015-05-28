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




#APP_PATH = '/Users/randysun/Desktop/certificate_Apple/PacteraPulse.app'
#ANDROID_APP_PATH = '/Users/randysun/Desktop/certificate_Apple/PacPulse.apk'
#appium -U cf2b7df852cafea74095ee487c9191744ef10d39 --app /Users/jin/Desktop/PacteraPulse.ipa
#appium &
require File.join(File.dirname(__FILE__), '.', 'generalDefines')

def desired_caps
  {
    caps: {
      platformName: ENV["PLATFORM"],
      deviceName:  getDeviceName(),
      versionNumber:  getVersionNumber(),
      app: getPackageName()
      
#      platformName: 'Android',
#      platformVersion: '5.1',
#      deviceName:       'Android Emulator',
#      app: ANDROID_APP_PATH

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

	after(:all) do
		driver_quit     
	end
	
  

	def back_click(opts={})
		opts ||= {}
		search_wait = opts.fetch(:wait, 10) # seconds
		wait(search_wait) { 
		  
		  
      if( ENV["PLATFORM"] == 'iOS') then
        button_exact('Back').click
      else
        back()
      end		
		}
	end

	def check_error()
		set_wait 1
		alertView = getGeneralAlert()
		if alertView.any?
      getOkButtonInAlert().click
			@error = true
		else 
			@error = false
		end
	end
	after(:all) do
		driver_quit
	end

	describe 'FirstTime Launch' do
		after :all do
			startButton = getStartInWelcome()
			if startButton.any?
				startButton[0].click
			end
			set_wait 10
		end

		before :all do
			sleep 10
		end

		it "can have a start Page on first launch, otherwise can't be seen", :filePath=> 'screenshot/1.png' do
			startButton = getStartInWelcome()
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/1.png")
			startButton.should_not be nil
			
		end
	end

	describe 'Login Page' do
		before :all do
			sleep 10
		end
		after :all do
			sleep 10
		end
		it 'should have the authorization process'  do
			webviews = find_elements(:class_name, 'UIAWebView')
			if webviews.any?
				webview = webviews[0]
				inputfields =  webview.find_element(:name,"User account")
				inputfields.type('mobiletest@pactera.com.au')
				sleep 5
				password = webview.find_element(:name, 'Password')
	     		sleep 1
	     		password.click
	     		sleep 1
	     		password.type('11PacteraPulse')
	     		sleep 3
			    title = webview.find_element(:name, 'PacteraPulseOpenSource')
			    title.click
			    sleep 4		     
			    signIn = webview.find_element(:name, 'Sign in')
			    signIn.click;   
			    sleep 7
			    userName = webview.find_element(:name, 'Accept')
			    userName.click
			    webview.displayed?.should be true 
			else
				webviews.should be nil
			end
		end
	end


	# describe 'Back to Welcome page' do
	# 	after :all do
	# 		if getStartInWelcome() != nil
 #        getStartInWelcome().click
	# 		end
	# 	end
	# 	it 'can back to the welcome page',:filePath=> 'screenshot/2.png' do
		  
 #      if( ENV["PLATFORM"] == 'iOS') then
 #        getStartInWelcome().click
 #        set_wait 2
 #        getBackButtonInVote().click
 #      else
 #        getStartInWelcome().click
 #        set_wait 2
 #        screenshot = driver.screenshot_as :base64
 #        screenshot("./screenshot/2.png") 
 #      end 

      
 #      set_wait 1
 #      #find_element(:name, 'Info').click
	# 		startButton = getStartInWelcome()
	# 		startButton.click
	# 		screenshot = driver.screenshot_as :base64
	# 		screenshot("./screenshot/2.png")			
	# 		startButton.displayed?.should be false
	# 	end
	# end

	describe 'Employee voting page' do
		after :all do
     		back_click
    	end	

		it 'can be in the voting page' ,:filePath=> 'screenshot/3.png' do
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/3.png")
			votingMainPage = getInsideVote
			votingMainPage.should_not be_nil;
		end

		it 'can vote happy emotion',:filePath=> 'screenshot/4.png' do
			getHappyButton().click
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
      		getReslutButtonInVote().click
			reusltPage = getInsideResult()
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
      		getHappyButton().click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/5.png")
			check_error
			if !@error
				back_click
			end
		end


		it 'can click unHappy button',:filePath=> 'screenshot/6.png'  do
      		getUnhappyButton().click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/6.png")
			check_error
			if !@error
				back_click
			end
		end

		it 'can click soso button',:filePath=> 'screenshot/7.png'  do
      		getNetrualButton().click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/7.png")
			check_error
		end

		it 'can click soso button',:filePath=> 'screenshot/8.png'  do
      		find_element(:name,'7 Days').click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/8.png")
			check_error
		end	

		it 'can click soso button',:filePath=> 'screenshot/9.png'  do
      		find_element(:name,'30 Days').click
			screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/9.png")
			check_error
		end		
	end

	describe 'Vote Detail Page' do
		after :all do
     		set_wait 3
    	end

    	def moveSlider(slider,percentage,moveLength)
	      actions = Appium::TouchAction.new
  		  pointX = (slider.size.width*percentage) + slider.location.x 
	      actions.press element: slider, x:pointX , y: 3
		  actions.move_to element: slider, x: (pointX + (slider.size.width*moveLength)), y: 3
		  actions.release
		  actions.perform	   	
    	end

		it 'shoud have moreinfo button when you are first time login at daytime or log out button when you have already voted' do
			moreInfo_button = find_element(:name,'More Info')
			if moreInfo_button != nil
				moreInfo_button.displayed?.should be true	
			else
				moreInfo_button.displayed?.should be false	
			end
		end

		it 'shoud navigate to voteDetail page',:filePath=> 'screenshot/10.png'  do
			moreInfo_button = find_element(:name,'More Info')
		    screenshot = driver.screenshot_as :base64
			screenshot("./screenshot/10.png")			
			if moreInfo_button != nil
				moreInfo_button.click
				sleep 4
				find_element(:name,'Submit').should_not be nil	
			end
		end

		it 'sliders should be changed',:filePath=> 'screenshot/11.png'  do
          actions = Appium::TouchAction.new
          if moreInfo_button != nil
	      	  sliders = find_elements(:class_name,'UIASlider')
		      if sliders.any?
			      if sliders[0].value == '20%'
			      	  moveSlider(sliders[0],0.2,0.2)
			      	  sleep 2
			      	  moveSlider(sliders[1],0.2,0.2)
			      	  sleep 2
			      	  moveSlider(sliders[2],0.2,0.3)

			      elsif sliders[0].value == '50%'
			      	  moveSlider(sliders[0],0.5,0.2)
			      	  sleep 2
			      	  moveSlider(sliders[1],0.5,0.2)
			      	  sleep 2
			      	  moveSlider(sliders[2],0.5,-0.3)
			      elsif sliders[0].value == '70%'
			      	  moveSlider(sliders[0],0.7,-0.4)
			      	  sleep 2
			      	  moveSlider(sliders[1],0.7,-0.2)
			      	  sleep 2
			      	  moveSlider(sliders[2],0.7,-0.3)
			      end
			     sliders[2].should_not be nil
		     end
		  end
		  screenshot("./screenshot/11.png")
		  screenshot = driver.screenshot_as :base64
		end
	end

	describe 'Vote Detail Page' do
		it 'should be a logout button as user has voted already',:filePath=> 'screenshot/12.png' do
			logout_button = find_element(:name, 'Logout')
			if logout_button != nil
				logout_button.click
				screenshot("./screenshot/11.png")
		  		screenshot = driver.screenshot_as :base64
		  		logout_button.should_not be nil
		  	else
		  		logout_button.should be nil
			end
		end


	end
end
