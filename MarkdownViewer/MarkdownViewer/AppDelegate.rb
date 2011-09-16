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
  attr_accessor :webView
  attr_accessor :filePath

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end

  def open(sender)
    panel = NSOpenPanel.openPanel
    panel.setCanChooseDirectories(false)
    file_types = ["md", "mkd", "markdown"]
    result = panel.runModalForDirectory(NSHomeDirectory(),
                                        file:nil, 
                                        types:file_types)
    if(result == NSOKButton)
      path = panel.filename
      filePath.stringValue = path
      self.convert(sender)
    end
  end
  
  
  def convert(sender)
    path  = File.expand_path(filePath.stringValue)
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
    webView.mainFrame.loadHTMLString(html, baseURL:nsurl)
  end
end

