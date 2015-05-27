require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'

#iOS/Android package
def getPackageName()
  if( ENV["PLATFORM"] == 'iOS') then
    return './PacteraPulse.app'
  else
    return './app-debug.apk'
  end

end

def getDeviceName()
  if( ENV["PLATFORM"] == 'iOS') then
    return 'iPhone 6 Plus'
  else
    return 'Android Emulator'
  end

end

def getVersionNumber()
  if( ENV["PLATFORM"] == 'iOS') then
    return '8.1'
  else
    return '5.1'
  end

end

#General error/alert handing
def getGeneralAlert()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name,'UIAAlert')
  else
    return find_elements(:class_name,'UIAAlert')
  end  
end

def getOkButtonInAlert()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'OK')
  else
    return find_element(:name, 'OK')
  end  
end



#Welcome page
def getStartInWelcome()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:name, 'Tap to start')
  else
    return find_element(:id, 'com.pactera.pacterapulseopensourceandroid:id/textView')
  end
end




#Vote page

def getBackButtonInVote()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Info')
  else
    #return find_element(:id, 'android:id/home')
    return id('com.pactera.pacterapulseopensourceandroid:id/home')
  end
end

def getReslutButtonInVote()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Share')
  else
    return id('com.pactera.pacterapulseopensourceandroid:id/action_showResults')
  end
end


def getInsideVote()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:class_name, 'UIATableView')
  else
    return id('com.pactera.pacterapulseopensourceandroid:id/btnSad')#if any buttons existed, it means entering the vote page
  end
end



def getHappyButton()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name, 'UIATableCell')[2]
  else
    return id('com.pactera.pacterapulseopensourceandroid:id/btnHappy')
  end
end

def getUnhappyButton()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name, "UIATableCell")[1]
  else
    return id('com.pactera.pacterapulseopensourceandroid:id/btnSad')
  end
end

def getNetrualButton()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name, "UIATableCell")[0]
  else
    return id('com.pactera.pacterapulseopensourceandroid:id/btnNeutral')
  end
end

#Result page
def getInsideResult()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name,'24 Hours Results')
  else
    return id('android:id/action_bar_title')
  end
end

