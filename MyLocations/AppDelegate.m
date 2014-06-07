//
//  AppDelegate.m
//  MyLocations
//
//  Created by Ryan Robinson on 5/4/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "AppDelegate.h"
#import "CurrentLocationViewController.h"
#import "LocationsViewController.h"
#import "MapViewController.h"

NSString * const ManagedObjectContextSaveDidFailNotification = @"ManagedObjectContextSaveDidFailNotification";

@interface AppDelegate() <UIAlertViewDelegate>
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
  CurrentLocationViewController *currentLocationViewController = (CurrentLocationViewController *)tabBarController.viewControllers[0];
  UINavigationController *navigaionController = (UINavigationController *)tabBarController.viewControllers[1];
  LocationsViewController *locationsViewController = (LocationsViewController *)navigaionController.viewControllers[0];
  MapViewController *mapViewController = (MapViewController *)tabBarController.viewControllers[2];
    
  currentLocationViewController.managedObjectContext = self.managedObjectContext;
  locationsViewController.managedObjectContext = self.managedObjectContext;
  mapViewController.managedObjectContext = self.managedObjectContext;
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fatalCoreDataError:) name:ManagedObjectContextSaveDidFailNotification object:nil];
  
  [self customizeAppearance];
  return YES;
}

- (void)fatalCoreDataError:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"InternalError", nil) message:NSLocalizedString(@"There was a Fatal Error in the App and it cannot continue.\n\nPress OK to terminate the app. Sorry for the inconvenience.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    
    [alertView show];
}

- (void)customizeAppearance
{
  [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
  
  [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],}];
  [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
}

#pragma mark - CoreData

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel == nil) {
        NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"DataModel" ofType:@"momd"];
        NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    return documentsDirectory;
}

- (NSString *)dataStorePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"DataStore.sqlite"];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator == nil) {
        NSURL *storeURL = [NSURL fileURLWithPath:[self dataStorePath]];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Error adding persistent store: %@, %@", error, [error userInfo]);
            
            abort();
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
        
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    abort();
}

@end
