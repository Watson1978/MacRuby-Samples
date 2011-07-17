#
#  AppDelegate.rb
#  mHTTPd
#
#  Created by Watson on 11/07/17.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require "webrick"

class AppDelegate
  SERVER_STOPED  = 1
  SERVER_STARTED = 2

  attr_accessor :window
  attr_accessor :doc_root, :server_port
  attr_accessor :http_toggle

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    @server_status = SERVER_STOPED
  end

  def toggle(sender)
    case @server_status
    when SERVER_STARTED
      stop
      @server_status = SERVER_STOPED
      http_toggle.title = "Start"
    when SERVER_STOPED
      start
      @server_status = SERVER_STARTED
      http_toggle.title = "Stop"
    end
  end

  private

  def start
    @server = WEBrick::HTTPServer.new(
    			:Port => @server_port.stringValue.to_i,
    			:DocumentRoot => File.expand_path(doc_root.stringValue)
    )

    @thread_httpd = Thread.new {
      @server.start
    }
  end

  def stop
    @server.shutdown
  end
end

