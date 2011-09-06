# -*- coding: utf-8 -*-
#
#  AppDelegate.rb
#  SourceList
#
#  Created by Watson on 11/09/06.
#  Copyright 2011. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :outline

  def awakeFromNib
    @data = [{:group => 'root', :child => ['foo', 'bar'] }]
    outline.expandItem(@data[0])
  end

  def outlineView(outlineView,
                  child:index,
                  ofItem:item)
    return nil if @data.nil?
    return @data[index] if item.nil?
    return item[:child][index]
  end

  def outlineView(outlineView,
                  numberOfChildrenOfItem:item)
    return @data.size if item.nil?
    return item[:child].size
  end

  def outlineView(outlineView,
                     isItemExpandable:item)
    return true if item.kind_of?(Hash)
    return false
  end

  def outlineView(outlineView,
                  objectValueForTableColumn:tableColumn,
                  byItem:item)
    return item[:group] if item.kind_of?(Hash)
    return item
  end

end

