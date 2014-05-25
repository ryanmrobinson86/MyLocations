//
//  FirstViewController.h
//  MyLocations
//
//  Created by Ryan Robinson on 5/4/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

@interface CurrentLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *tagButton;
@property (nonatomic, weak) IBOutlet UIButton *getButton;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)getLocation:(id)sender;
- (void)updateLabels;
- (void) stopLocationManager;
- (void) startLocationManager;

@end
