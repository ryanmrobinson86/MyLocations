//
//  LocationsViewController.h
//  MyLocations
//
//  Created by Ryan Robinson on 5/24/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

@interface LocationsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
