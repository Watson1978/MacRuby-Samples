#
#  ExifImageView.rb
#  ExifViewer
#
#  Created by Watson on 11/09/18.
#
class ExifImageView < NSImageView
  attr_accessor :delegate
  
  def init
    if super
      self.registerForDraggedTypes([NSFilenamesPboardType])
      return self
    end
  end
  
  def draggingEntered(sender)
    return NSDragOperationGeneric
  end
  
  def performDragOperation(sender)
    return delegate.performDragOperation(sender)
  end  
end

