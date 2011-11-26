#
#  AppDelegate.rb
#  SouceListBinding
#
#  Created by Watson _ on 11/09/14.
#  Copyright 2011年 __MyCompanyName__. All rights reserved.
#

class AppDelegate
  attr_accessor :window, :outline
  attr_accessor :treeController

  # NSOutlineView
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    data = {"name"  => "root",      
             "child" => [
              {"name" => "Group 1"},
              {"name" => "Group 2"}]
    }
    @treeController.setContent(data)
    outline.expandItem(nil, expandChildren:true)
    outline.selectRowIndexes(NSIndexSet.indexSetWithIndex(2), byExtendingSelection:false)
  end

  def outlineView(outlineView,
                  isGroupItem:item)
    return false if outlineView.parentForItem(item)
    return true
  end

  def outlineView(outlineView,
                  shouldSelectItem:item)
    return false unless outlineView.parentForItem(item)
    return true
  end
  
  
end

