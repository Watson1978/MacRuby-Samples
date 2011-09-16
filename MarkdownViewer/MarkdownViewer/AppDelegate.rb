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

  def convert(sender)
    path = File.expand_path(filePath.stringValue)
    md = RDiscount.new(File.read(path))
    html = md.to_html
    webView.mainFrame.loadHTMLString(html, baseURL:nil)
  end
end

