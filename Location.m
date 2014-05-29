//
//  Location.m
//  MyLocations
//
//  Created by Ryan Robinson on 5/19/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "Location.h"


@implementation Location

@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic locationDescription;
@dynamic category;
@dynamic placemark;
@dynamic photoId;

#pragma mark - Map

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title
{
    if ([self.locationDescription length] > 0) {
        return self.locationDescription;
    } else {
        return @"(No Description)";
    }
}

- (NSString *)subtitle
{
    return self.category;
}

#pragma mark - Photo

- (BOOL)hasPhoto
{
    return (self.photoId != nil) && ([self.photoId integerValue] != -1);
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    return documentsDirectory;
}

- (NSString *)photoPath
{
    NSString *fileName = [NSString stringWithFormat:@"Photo-%d.jpg", [self.photoId integerValue]];
    return [[self documentsDirectory] stringByAppendingPathComponent:fileName];
}

- (UIImage *)photoImage
{
    NSAssert(self.photoId != nil, @"No Photo Set");
    NSAssert([self.photoId integerValue] != -1, @"Photo Id is -1");
    
    return [UIImage imageWithContentsOfFile:[self photoPath]];
}

+ (NSInteger)nextPhotoId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger photoId = [defaults integerForKey:@"PhotoId"];
    [defaults setInteger:photoId+1 forKey:@"PhotoId"];
    [defaults synchronize];
    return photoId;
}

- (void)removePhotoFile
{
    NSString *path = [self photoPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error;
        if (![fileManager removeItemAtPath:path error:&error]) {
            NSLog(@"Error removing file: %@", error);
        }
    }
}

@end
