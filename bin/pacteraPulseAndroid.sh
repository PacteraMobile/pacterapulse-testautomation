SERVICE='appium'

#check if appium is started
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
	echo "$SERVICE service running, everything is fine"
else
	#run the appium server
	echo "$SERVICE is not running"
	appium --full-reset &
fi

#enter into the Test project folder
cp ${WORKSPACE}/pacterapulseAndroid/app/build/outputs/apk/app-debug.apk ${WORKSPACE}/PacteraPulseTest
cd ${WORKSPACE}/PacteraPulseTest
#update gem libray
bundle update
#Run test cases
PLATFORM=Android rspec ./spec/lib/u_i_pacteraPlus.rb --require ./format/custom_formatter.rb --format CustomFormatter --out report.html