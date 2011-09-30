#
#  AppDelegate.rb
#  BoundDockIcon
#
#  Created by Watson on 11/09/30.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end
  
  def boundDockIcon(sender)
    NSApp.hide(nil)
    Thread.start {
      sleep 1
      NSApp.requestUserAttention(NSCriticalRequest)
    }
  end
end

