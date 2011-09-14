#
#  AppDelegate.rb
#  ViewBasedCell
#
#  Created by Watson _ on 11/09/14.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :table

  def awakeFromNib
    @data = [
      {'icon' => "twitter", 'name' => 'foo'},
      {'icon' => "facebook", 'name' => 'bar'},
    ]
  end
  
  def numberOfRowsInTableView(tableView)
    @data.size
  end

  def tableView(tableView,
                viewForTableColumn:tableColumn,
                row:row)
    view = tableView.makeViewWithIdentifier(tableColumn.identifier, owner:self)
    image = NSImage.imageNamed(@data[row]['icon'])
    #view.imageView.setImage(image)
    view.imageView.image = image
    view.textField.stringValue = @data[row]['name']
    return view
  end


end

