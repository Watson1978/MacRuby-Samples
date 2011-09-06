#
#  AppDelegate.rb
#  mHTTPd
#
#  Created by Watson on 11/07/17.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require "webrick"

class AppDelegate
  attr_accessor :window
  attr_accessor :doc_root, :server_port, :server_name
  attr_accessor :http_toggle

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    @server_status = :stoped
  end

  def toggle(sender)
    case @server_status
    when :started
      stop
      @server_status = :stoped
      http_toggle.title = "Start"
    when :stoped
      start
      @server_status = :started
      http_toggle.title = "Stop"
    end
  end

  def openFolder(sender)
    panel = NSOpenPanel.openPanel
    panel.setCanChooseFiles(false)
    panel.setCanChooseDirectories(true)
    dir = File.expand_path(doc_root.stringValue)
    result = panel.runModalForDirectory(dir,
                                        file:nil, 
                                        types:nil)
    if(result == NSOKButton)
      path = panel.filename
      @doc_root.stringValue = path
    end
  end

  private

  def start
    name = @server_name.stringValue
    root = @doc_root.stringValue
    port = @server_port.stringValue.to_i
    @server = WEBrick::HTTPServer.new(
    			:Port => port,
    			:DocumentRoot => File.expand_path(root)
    )

    # Bonjour
    @netservice = NSNetService.alloc.initWithDomain("", type:"_http._tcp", name:name, port:port)
    @netservice.publish

    # httpd
    Thread.new {
      @server.start
    }
  end

  def stop
    @server.shutdown
    @netservice.stop
  end
end