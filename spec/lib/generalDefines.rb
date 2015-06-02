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

#Authenticaton
def getStaticUserName()
  return "mobiletest@pactera.com.au"
end
def getStaticPassword()
  return "11PacteraPulse"
end


def getAuthenPageWebView()
  if( ENV["PLATFORM"] == 'iOS') then
      return webviews = find_elements(:class_name, 'UIAWebView')
    else 
      return webviews = find_elements(:xpath, '//android.view.View[1]/android.widget.FrameLayout[2]/android.widget.RelativeLayout[1]/android.webkit.WebView[1]/android.webkit.WebView')
    end
end

def getAcceptPageWebView()
  if( ENV["PLATFORM"] == 'iOS') then
      return webviews = find_elements(:class_name, 'UIAWebView')
    else 
      #return webviews = find_elements(:xpath, '//android.view.View[1]/android.widget.FrameLayout[2]/android.widget.RelativeLayout[1]/android.webkit.WebView[1]/android.webkit.WebView')      
      return webviews = find_elements(:xpath, '//android.view.View[1]/android.widget.FrameLayout[2]/android.widget.RelativeLayout[1]/android.webkit.WebView[1]/android.webkit.WebView')
    end
end

def getAuthenPageInfo() 
  if( ENV["PLATFORM"] == 'iOS') then
      return find_element(:name, 'PacteraPulseOpenSource')
    else
      #return find_element(:id, 'com.pactera.pacterapulse:id/textView')
    end
end

def getAuthenUserName()
  if( ENV["PLATFORM"] == 'iOS') then
    #webview = find_elements(:class_name, 'UIAWebView')[0]  
    webview = find_elements(:type, 'UIAWebView')[0]  
    return webview.find_element(:name, 'User account')
  else
    #return find_element(:id, 'com.pactera.pacterapulse:id/textView')
  end
end

def getAuthenPassword()
  if( ENV["PLATFORM"] == 'iOS') then
    webview = find_element(:class_name, 'UIAWebView')
    return webview.find_element(:name, 'Password')
  else
    #return find_element(:id, 'com.pactera.pacterapulse:id/textView')
  end
end

def getAuthenSignInBtn()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Sign in')
  else
    #return find_element(:id, 'com.pactera.pacterapulse:id/textView')
  end  
end

def getAuthenCancelBtn()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Cancel')
  else
    #return find_element(:id, 'com.pactera.pacterapulse:id/textView')
  end  
end



#Welcome page
def getStartInWelcome()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Tap to start')
  else
    #return find_element(:id, 'au.com.pactera.pacterapulse:id/textView')
    return find_element(:id, 'au.com.pactera.pacterapulse:id/btnAgree')
  end
end




#Vote page

def getBackButtonInVote()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Info')
  else
    #return find_element(:id, 'android:id/home')
    return id('au.com.pactera.pacterapulse:id/home')
  end
end

def getReslutButtonInVote()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:name, 'Share')
  else
    return id('com.pactera.pacterapulse:id/action_showResults')
  end
end


def getInsideVote()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_element(:class_name, 'UIATableView')
  else
    #au.com.pactera.pacterapulse:id/btnSad
    return id('au.com.pactera.pacterapulse:id/btnSad')#if any buttons existed, it means entering the vote page
  end
end



def getHappyButton()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name, 'UIATableCell')[2]
  else
    return id('au.com.pactera.pacterapulse:id/btnHappy')
  end
end

def getUnhappyButton()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name, "UIATableCell")[1]
  else
    return id('au.com.pactera.pacterapulse:id/btnSad')
  end
end

def getNetrualButton()
  if( ENV["PLATFORM"] == 'iOS') then
    return find_elements(:class_name, "UIATableCell")[0]
  else
    return id('au.com.pactera.pacterapulse:id/btnNeutral')
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

