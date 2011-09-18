#
#  AppDelegate.rb
#  ExifViewer
#
#  Created by Watson on 11/09/18.
#
class AppDelegate
  attr_accessor :window
  attr_accessor :imageView
  attr_accessor :arrayController

  FILE_TYPES = ["jpg", "jpeg"]

  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    imageView.delegate = self
  end
  
  def application(theApplication,
                  openFile:path)
    image = NSImage.alloc.initWithContentsOfFile(path)
    imageView.image = image
    viewMetaData(path)
    return true
  end

  def performDragOperation(sender)
    pbd = sender.draggingPasteboard
    files = pbd.propertyListForType(NSFilenamesPboardType)
    
    # reject multiple files
    return NSDragOperationNone if files.count > 1
    # reject unknown file types
    return NSDragOperationNone if !can_open?(files.last)

    viewMetaData(files.last)
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
      image = NSImage.alloc.initWithContentsOfFile(path)
      imageView.image = image
      viewMetaData(path)
    end
  end

  def viewMetaData(file)
    nsurl = NSURL.fileURLWithPath(file)
    imageSource = CGImageSourceCreateWithURL(nsurl, nil)
    metadata = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil);

    arrayController.removeObjects(arrayController.arrangedObjects)
    addMetaDataInfo(metadata[KCGImagePropertyJFIFDictionary])
    addMetaDataInfo(metadata[KCGImagePropertyExifDictionary])
    addMetaDataInfo(metadata[KCGImagePropertyGPSDictionary])
  end

  def addMetaDataInfo(hash)
    if hash
      hash.each do |key, value|
        arrayController.addObject({'tag' => key, 'field' => value.inspect})
      end
    end
  end

  def can_open?(path)
    FILE_TYPES.each do |ext|
      if File.extname(path).downcase == "." + ext
        return true
      end
    end
    return false
  end
end

