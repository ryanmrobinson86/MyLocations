//
//  HudView.m
//  MyLocations
//
//  Created by Ryan Robinson on 5/18/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "HudView.h"

@implementation HudView

+ (instancetype)hudInView:(UIView *)view animated:(BOOL)animated
{
    HudView *hudView = [[HudView alloc] initWithFrame:view.bounds];
    
    hudView.opaque = NO;
    
    [view addSubview:hudView];
    view.userInteractionEnabled = NO;
    
    return hudView;
}

- (void)drawRect:(CGRect)rect
{
    const CGFloat boxWidth = 96.0f;
    const CGFloat boxHeight = 96.0f;
    
    CGRect boxRect = CGRectMake(roundf(self.bounds.size.width - boxWidth) / 2, roundf(self.bounds.size.height - boxHeight) / 2, boxWidth, boxHeight);
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:boxRect cornerRadius:10.0f];
    [[UIColor colorWithWhite:0.3f alpha:0.8f] setFill];
    [roundedRect fill];
}

@end
