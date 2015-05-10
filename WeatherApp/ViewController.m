//
//  ViewController.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 09/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mCoordinateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLatitude;
@property (weak, nonatomic) IBOutlet UILabel *mLongitude;

@end

@implementation ViewController
@synthesize mCoordinateLabel;
@synthesize mLatitude;
@synthesize mLongitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mLocationManager = [[CLLocationManager alloc] init];
    
    mCoordinateLabel.text = @"The weather is: ";
}

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (IBAction)mGetCurrentLocation:(id)sender {
    mLocationManager.delegate = self;
    mLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([mLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [mLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [mLocationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [mLocationManager requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    [mLocationManager startUpdatingLocation];
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        mLongitude.text = [NSString stringWithFormat:@"Long: %.8f", currentLocation.coordinate.longitude];
        mLatitude.text = [NSString stringWithFormat:@"Lat: %.8f", currentLocation.coordinate.latitude];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
