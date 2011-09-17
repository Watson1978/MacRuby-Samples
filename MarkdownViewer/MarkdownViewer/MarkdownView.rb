#
#  MarkdownView.rb
#  MarkdownViewer
#
#  Created by Watson on 11/09/16.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#


class MarkdownView < WebView

  def initWithFrame(rect)
    if super
      self.registerForDraggedTypes([NSFilenamesPboardType])
      self
    end
  end
  
  def setDelegate(sender)
    @delegate = sender
  end

  def performDragOperation(sender)
    return @delegate.performDragOperation(sender)
  end
  

end