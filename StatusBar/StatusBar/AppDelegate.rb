#
#  AppDelegate.rb
#  StatusBar
#
#  Created by Watson _ on 11/09/09.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :menu # Outlet of NSMenu

  def applicationDidFinishLaunching(a_notification)
    image = NSImage.imageNamed "status_bar_icon"
    size = NSSize.new
    size.width = size.height = 16
    image.setSize size

    status = NSStatusBar.systemStatusBar
    item = status.statusItemWithLength(NSVariableStatusItemLength)
    item.setTitle "test"
    item.setImage image
    item.setMenu menu
  end
end

