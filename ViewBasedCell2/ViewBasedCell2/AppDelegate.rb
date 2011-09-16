#
#  AppDelegate.rb
#  ViewBasedCell2
#
#  Created by Watson on 11/09/15.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :arrayController

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    ary = []
    ary << {'icon' => NSImage.imageNamed('twitter'),  'name' => 'Twitter'}
    ary << {'icon' => NSImage.imageNamed('facebook'), 'name' => 'Facebook'}
      
    arrayController.addObjects(ary)
  end
end

