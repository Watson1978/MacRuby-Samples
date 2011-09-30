#
#  AppDelegate.rb
#  Badge
#
#  Created by Watson on 11/09/30.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :textField
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end
  
  def showBadge(sender)
    text = textField.stringValue

    dock = NSApp.dockTile
    dock.badgeLabel = text
    dock.display
  end
end

