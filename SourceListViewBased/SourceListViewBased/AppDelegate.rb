class AppDelegate
  attr_accessor :window
  attr_accessor :outline
  
  def awakeFromNib
    @data = [{
      :type => :group,
      "name" => "root",
      :child => [
      {:type => :child, "name" => "twitter",  "icon" => NSImage.imageNamed('twitter')},
      {:type => :child, "name" => "facebook", "icon" => NSImage.imageNamed('facebook')}
      ]
    }]
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
    return true if item[:type] == :group
    return false
  end
  
  def outlineView(outlineView,
                  viewForTableColumn:tableColumn,
                  item:item)
    if item[:type] == :group
      # group
      view = outlineView.makeViewWithIdentifier("HeaderCell", owner:self)
      p item['name']
      view.textField.stringValue = item['name']
      else
      # child
      view = outlineView.makeViewWithIdentifier("DataCell", owner:self)
      view.imageView.image = item['icon']
      view.textField.stringValue = item['name']
    end
    return view
  end
  
end
