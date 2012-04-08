#
#  BlackCell.rb
#  EDSidebar
#
#  Created by Watson on 12/04/08.
#

class BlackCell < NSButtonCell
  def init
    super
    @shadow = NSShadow.alloc.init
    self.setHighlightsBy(NSContentsCellMask)

    self
  end

  def drawWithFrame(frame,
                    inView: view)
    NSColor.blackColor.setFill
    NSRectFill(frame)
    img = nil

    # Just a test. Should handle highlight better
    if self.state == NSOnState
      img = self.image
    else
      img = self.alternateImage
    end
    NSGraphicsContext.saveGraphicsState

    if self.isHighlighted
      img = self.image
      # simulate outer glow using a shadow
      @shadow.setShadowColor(NSColor.colorWithDeviceRed(115.0/225.0,
                                                        green: 215.0/225.0,
                                                        blue: 245.0/225.0,
                                                        alpha: 1.0))
      @shadow.setShadowBlurRadius(5)
      @shadow.setShadowOffset(NSMakeSize(0, 0))
      @shadow.set
    end

    imgRect = NSInsetRect(frame,
                          (NSWidth(frame) - img.size.width)/2.0,
                          (NSHeight(frame) - img.size.height)/2.0)
    img.drawInRect(imgRect,
                   fromRect: NSZeroRect,
                   operation: NSCompositeSourceOver,
                   fraction: 1.0,
                   respectFlipped: true,
                   hints: nil)
    NSGraphicsContext.restoreGraphicsState
  end
end
