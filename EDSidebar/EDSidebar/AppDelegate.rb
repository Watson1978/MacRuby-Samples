#
#  AppDelegate.rb
#  EDSidebar
#
#  Created by Watson on 12/04/08.
#

# To create BridgeSupport, run below command on Terminal
#   $ gen_bridge_metadata -c '-I EDSideBar' EDSideBar.h > EDSideBar.bridgesupport
resource_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
EDSideBarBridgeSupport = "EDSideBar.bridgesupport"
load_bridge_support_file "#{resource_path}/#{EDSideBarBridgeSupport}"

class AppDelegate
  attr_accessor :window
  attr_accessor :sideBarDefault, :sideBarBlack
  attr_accessor :textField

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end

  def awakeFromNib
    # Setup sidebar with default cell (EDSideBarCell)
    # Buttons top-aligned. Selection animated
    sideBarDefault.setLayoutMode(ECSideBarLayoutTop)
    sideBarDefault.animateSelection = true
    sideBarDefault.sidebarDelegate = self
    selImage = self.buildSelectionImage
    sideBarDefault.setSelectionImage(selImage)
    sideBarDefault.addButtonWithTitle("Button 1",
                                      image: NSImage.imageNamed("icon1-white.png"),
                                      alternateImage: NSImage.imageNamed("icon1-gray.png"))
    sideBarDefault.addButtonWithTitle("Button 2",
                                      image: NSImage.imageNamed("icon1-white.png"),
                                      alternateImage: NSImage.imageNamed("icon1-gray.png"))
    sideBarDefault.addButtonWithTitle("Button 3",
                                      image: NSImage.imageNamed("icon1-white.png"),
                                      alternateImage: NSImage.imageNamed("icon1-gray.png"))
    sideBarDefault.selectButtonAtRow(2)
    # Add a bit of noise texture
    sideBarDefault.noiseAlpha = 0.04

    # Setup sidebar with blackCell (BlackCell)
    # Buttons centered. Selection is not animated
    sideBarBlack.backgroundColor = NSColor.blackColor
    sideBarBlack.setLayoutMode(ECSideBarLayoutCenter)
    sideBarBlack.animateSelection = false
    sideBarBlack.sidebarDelegate = self;
    sideBarBlack.cellClass = BlackCell
    sideBarBlack.setSelectionImage(NSImage.imageNamed("blue.png"))
    sideBarBlack.addButtonWithTitle("Btn1",
                                    image: NSImage.imageNamed("icon1-blue.png"),
                                    alternateImage: NSImage.imageNamed("icon1-gray.png"))
    sideBarBlack.addButtonWithTitle("Btn2",
                                    image: NSImage.imageNamed("icon1-blue.png"),
                                    alternateImage: NSImage.imageNamed("icon1-gray.png"))
    sideBarBlack.addButtonWithTitle("Btn3",
                                    image: NSImage.imageNamed("icon1-blue.png"),
                                    alternateImage: NSImage.imageNamed("icon1-gray.png"))
    sideBarBlack.selectButtonAtRow(0)
  end

  def buildSelectionImage
    # Create the selection image on the fly, instead of loading from a file resource.
    imageWidth  = 12
    imageHeight = 22
    destImage = NSImage.alloc.initWithSize(NSMakeSize(imageWidth, imageHeight))

    destImage.lockFocus

    # Constructing the path
    triangle = NSBezierPath.bezierPath
    triangle.setLineWidth(1.0)
    triangle.moveToPoint(NSMakePoint(imageWidth+1, 0.0))
    triangle.lineToPoint(NSMakePoint(0, imageHeight/2.0))
    triangle.lineToPoint(NSMakePoint(imageWidth+1, imageHeight))
    triangle.closePath
    NSColor.controlColor.setFill
    NSColor.darkGrayColor.setStroke
    triangle.fill
    triangle.stroke

    destImage.unlockFocus

    destImage;
  end

  def sideBar(tabBar,
              didSelectButton: button)
    sidebar = "Right sidebar"
    sidebar = "Left sidebar" if tabBar.isEqualTo(sideBarBlack)
    string = NSString.stringWithFormat("Selected button %@ in %@",
                                       button,
                                       sidebar)
    NSLog("Button selected: %@", button)
    textField.setStringValue(string)
  end
end

