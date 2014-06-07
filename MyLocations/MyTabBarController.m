//
//  MyTabBarController.m
//  MyLocations
//
//  Created by Ryan Robinson on 6/7/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
  return nil;
}

@end
