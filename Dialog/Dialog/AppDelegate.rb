#
#  AppDelegate.rb
#  Dialog
#
#  Created by Watson on 11/09/30.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :sheet
  
  CODE_OK = 127

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end
  
  def showSheet(sender)
    NSApp.beginSheet(sheet,
                     modalForWindow:window,
                     modalDelegate:self,
                     didEndSelector:NSSelectorFromString("sheetDidEnd:returnCode:contextInfo:"),
                     contextInfo:nil)
  end

  def dialogOk(sender)
    NSApp.endSheet(sheet, returnCode:CODE_OK)
  end
  
  def sheetDidEnd(sheet, returnCode:code, contextInfo:info)
    p code
    sheet.orderOut(self)
  end
end

