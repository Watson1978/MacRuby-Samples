#
#  AppDelegate.rb
#  MarkdownViewer
#
#  Created by Watson on 11/09/16.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#
require 'rubygems'
require 'rdiscount'

class AppDelegate
  attr_accessor :window
  attr_accessor :markdownView

  FILE_TYPES = ["md", "mkd", "markdown"]

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    markdownView.setDelegate(self)
    @file_path = ""
  end

  def applicationOpenUntitledFile(sender)
    self.displayWindow
    return true
  end

  def performDragOperation(sender)
    pbd = sender.draggingPasteboard
    files = pbd.propertyListForType(NSFilenamesPboardType)
    if files.count > 1
      # reject multiple files
      return NSDragOperationNone
    end
    
    path = files.last
    ok = false
    FILE_TYPES.each do |ext|
      if File.extname(path) == "." + ext
        ok = true
        break
      end
    end
    
    return NSDragOperationNone if !ok

    @file_path = path
    self.convert(sender)
    return NSDragOperationGeneric
  end

  def open(sender)
    panel = NSOpenPanel.openPanel
    panel.setCanChooseDirectories(false)
    result = panel.runModalForDirectory(NSHomeDirectory(),
                                        file:nil, 
                                        types:FILE_TYPES)
    if(result == NSOKButton)
      path = panel.filename
      @file_path = path
      self.convert(sender)
    end
  end

  def convert(sender)
    return if @file_path.length == 0
    self.displayWindow

    path  = File.expand_path(@file_path)
    dir   = File.dirname(path) + "/"
    nsurl = NSURL.URLWithString(dir)

    res_path = NSBundle.mainBundle.resourcePath
    
    md = RDiscount.new(File.read(path))
    html =<<"EOS"
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="#{res_path}/style.css">
</head>
<body>
#{md.to_html}
</body>
</html>
EOS
    markdownView.mainFrame.loadHTMLString(html, baseURL:nsurl)
  end
  
  def displayWindow
    window.makeKeyAndOrderFront(nil)
    if markdownView.mainFrame.nil?
      rect = window.frame
      rect.origin.x = 0
      rect.origin.y = 0
      markdownView.initWithFrame(rect, frameName:"", groupName:"")
    end
  end
end

