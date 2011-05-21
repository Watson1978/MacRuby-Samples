# -*- coding: utf-8 -*-
#
#  Controller.rb
#  test
#
#  Created by Watson on 11/05/09.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
begin
  framework "CorePlot"

  CorePlotBridge = File.join(File.dirname(__FILE__), 'CorePlot.bridgesupport')
  unless(File.exist?(CorePlotBridge))
    system("gen_bridge_metadata --framework CorePlot -o #{CorePlotBridge}")
  end
  load_bridge_support_file CorePlotBridge
rescue
  NSLog "Needs CorePlot framework. Please install it."
  exit
end
    
class Controller
  attr_accessor :hostingView # outlet

  def awakeFromNib
    # create graph
    graph = CPXYGraph.alloc.initWithFrame(hostingView.bounds)
    hostingView.hostedLayer = graph;
    theme = CPTheme.themeNamed(KCPSlateTheme)
    graph.applyTheme(theme)

    # range
    plotSpace = graph.defaultPlotSpace;
    # plotSpace.xRange = CPPlotRange.plotRangeWithLocation(CPDecimalFromFloat(0), length:CPDecimalFromFloat(10))
    # plotSpace.yRange = CPPlotRange.plotRangeWithLocation(CPDecimalFromFloat(0), length:CPDecimalFromFloat(10))
    plotSpace.xRange.setLocation(CPDecimalFromFloat(0.0))
    plotSpace.xRange.setLength(CPDecimalFromFloat(10.0))
    plotSpace.yRange.setLocation(CPDecimalFromFloat(0.0))
    plotSpace.yRange.setLength(CPDecimalFromFloat(10.0))

    graph.paddingBottom = 25;
    graph.paddingLeft = 25;
      
    logPlot = CPScatterPlot.alloc.init
    logPlot.identifier = "plot"
    logPlot.dataSource = self
    graph.addPlot(logPlot)
  end

  def numberOfRecordsForPlot(plot)
    10
  end

  def numberForPlot(plot,
                    field:fieldEnum,
                    recordIndex:index)
    if (fieldEnum == CPScatterPlotFieldX)
      return index
    else
      return Math.log(index * index)
    end
  end
end
