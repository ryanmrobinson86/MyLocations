//
//  NSMutableArray+AddText.m
//  MyLocations
//
//  Created by Ryan Robinson on 6/7/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "NSMutableArray+AddText.h"

@implementation NSMutableString (AddText)

- (void)addText:(NSString *)text withSeparator:(NSString *)separator
{
  if (text != nil) {
    if([self length] > 0) {
      [self appendString:separator];
    }
    [self appendString:text];
  }
}

@end
