#
#  AppDelegate.rb
#  Service
#
#  Created by Watson on 11/10/02.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

# Google Translate API key
API_KEY = 'AIzaSyDNLefOLDCAlDm5niZP_2LX7RIEdmnPwbM'

require 'json'
require 'uri'
require 'open-uri'

class AppDelegate
  attr_accessor :window
  attr_accessor :text # Text View Outlet

  def applicationDidFinishLaunching(a_notification)
    NSApp.setServicesProvider(self)
  end

  def doService(pboard, userData:userData, error:error)
    window.makeKeyAndOrderFront(nil)
    string = pboard.stringForType(NSStringPboardType)

    translate(string)
  end
  
  def translate(string)
    source = 'en'
    target = 'ja'
    
    if string.length > 0
      open(URI.escape("https://www.googleapis.com/language/translate/v2?key=#{API_KEY}&source=#{source}&target=#{target}&q=#{string}")) {|f|
        str = f.read
        js = JSON.parse(str)
        text.setString(js['data']['translations'][0]['translatedText'])
      }
    end
  end
end

