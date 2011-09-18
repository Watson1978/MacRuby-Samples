//
//  main.m
//  ExifViewer
//
//  Created by Watson on 11/09/18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
