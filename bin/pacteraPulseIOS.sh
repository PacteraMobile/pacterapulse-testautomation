SERVICE='appium'

#check if appium is installed or not
if ! type appium >/dev/null 2>&1 ;then
	npm install -g appium  #install appium
	npm install wd #install appium clinet
	appium &  #start appium
else 
	#check if appium is started
	if ps ax | grep -v grep | grep $SERVICE > /dev/null
	then
    	echo "$SERVICE service running, everything is fine"
	else
		#run the appium server
    	echo "$SERVICE is not running"
    	appium &
	fi
fi

#enter into the PacteraPulse workspace
cd ${WORKSPACE}/pacterapulseIOS
#This project uses CocoaPods for dependancy Management, install the dependancy first
pod install
#install xctool 
if ! type xctool >/dev/null 2>&1 ;then
	brew install xctool
fi
#unit test
xctool -workspace PacteraPulse.xcworkspace -scheme PacteraPulse -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6' -reporter junit:${WORKSPACE}/pacteraPulseJUnit.xml test
#build the project
xcodebuild -workspace PacteraPulse.xcworkspace -scheme PacteraPulse -sdk iphonesimulator -configuration Debug -derivedDataPath ./build build
#copy app file to root of Test project folder
find . -name PacteraPulse.app | xargs -I{} cp -r {} ${WORKSPACE}/PacteraPulseTest
#remove the build folder after building
#rm -rf build
#enter into the Test project folder
cd ${WORKSPACE}/PacteraPulseTest
#undate gem libray
bundle update
#run test case
PLATFORM=iOS rspec spec/lib/u_i_pacteraPlus.rb --require ./format/custom_formatter.rb --format CustomFormatter --out report.html

