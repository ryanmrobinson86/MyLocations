//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by Ryan Robinson on 5/10/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

@interface LocationDetailsViewController : UITableViewController

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLPlacemark *placemark;

@end
