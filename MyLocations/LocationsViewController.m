//
//  LocationsViewController.m
//  MyLocations
//
//  Created by Ryan Robinson on 5/24/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "LocationsViewController.h"
#import "Location.h"
#import "LocationCell.h"
#import "LocationDetailsViewController.h"

@implementation LocationsViewController
{
    NSArray *_locations;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *foundObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (foundObjects == nil) {
        FAIL_CORE_DATA_ERROR(error);
        return;
    }
    
    _locations = foundObjects;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"EditLocation"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        LocationDetailsViewController *locationDetailsViewController = (LocationDetailsViewController *)navigationController.topViewController;
        
        locationDetailsViewController.managedObjectContext = self.managedObjectContext;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Location *location = _locations[indexPath.row];
        locationDetailsViewController.locationToEdit = location;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    LocationCell *locationCell = (LocationCell *)cell;
    Location *location = _locations[indexPath.row];
    
    if ([location.locationDescription length] > 0) {
        locationCell.descriptionLabel.text = location.locationDescription;
    } else {
        locationCell.descriptionLabel.text = @"(No Description)";
    }
    if (location.placemark != nil) {
        locationCell.addressLabel.text = [NSString stringWithFormat:@"%@ %@, %@", location.placemark.subThoroughfare, location.placemark.thoroughfare, location.placemark.locality];
    } else {
        locationCell.addressLabel.text = @"Lat: %.8f, Long: %.8f", [location.latitude doubleValue], [location.longitude doubleValue];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Location"];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

@end
