//
//  HudView.h
//  MyLocations
//
//  Created by Ryan Robinson on 5/18/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

@interface HudView : UIView

+ (instancetype)hudInView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic, strong) NSString *text;

@end
