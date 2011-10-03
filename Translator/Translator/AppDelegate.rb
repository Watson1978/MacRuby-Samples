#
#  AppDelegate.rb
#  Translator
#
#  Created by Watson on 11/05/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

# Google Translate API key
API_KEY = 'AIzaSyDNLefOLDCAlDm5niZP_2LX7RIEdmnPwbM'

class AppDelegate
  require 'json'
  require 'uri'
  require 'open-uri'

  attr_accessor :window, :text # outlet

  def applicationDidFinishLaunching(a_notification)
    NSApp.setServicesProvider(self)
  end

  def doService(pboard, userData:userData, error:error)
    window.makeKeyAndOrderFront(nil)
    string = pboard.stringForType(NSStringPboardType)

    translate(string)
  end

  # delegator, action
  def execTranslate(sender)
    string = getText
    translate(string)
  end

  def translate(str)
    source = 'en'
    target = 'ja'
    if str.length > 0
      open(URI.escape("https://www.googleapis.com/language/translate/v2?key=#{API_KEY}&source=#{source}&target=#{target}&q=#{str}")) {|f|
        str = f.read
        js = JSON.parse(str)
        insertText(js['data']['translations'][0]['translatedText'])
      }
    end
  end

  def textPaste(sender)
    pboard = NSPasteboard.generalPasteboard
    insertText(pboard.stringForType(NSStringPboardType))
  end

  def textCopy(sender)
    pboard = NSPasteboard.generalPasteboard
    pboard.declareTypes([NSStringPboardType], owner:nil);
    pboard.setString(getText.to_s, forType:NSStringPboardType)
  end

  def windowWillClose(sender)
    exit
  end

  private

  def getText
    text.stringValue
  end

  def insertText(str)
    text.setStringValue(str.to_s)
  end
end

