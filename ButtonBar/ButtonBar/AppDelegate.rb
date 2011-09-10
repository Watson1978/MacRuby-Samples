#
#  AppDelegate.rb
#  ButtonBar
#
#  Created by Watson _ on 11/09/10.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window, :text
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end
  
  def say(sender)
    text.stringValue = "Hello"
  end
end

