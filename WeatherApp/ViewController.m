//
//  ViewController.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 09/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "ViewController.h"
#import "RestClient.h"
#import "DataModels.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mLatitude;
@property (weak, nonatomic) IBOutlet UILabel *mLongitude;
@property (weak, nonatomic) IBOutlet UILabel *mTemperature;
@property (weak, nonatomic) IBOutlet UILabel *mConditions;
@property (weak, nonatomic) IBOutlet UIImageView *mWeatherIcon;

@end

@implementation ViewController
@synthesize mLatitude;
@synthesize mLongitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mLocationManager = [[CLLocationManager alloc] init];
    
    [self mGetCurrentLocation];
    
}


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)mGetCurrentLocation {
    mLocationManager.delegate = self;   //store a reference from my class in CLLocation
    mLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    mLocationManager.distanceFilter = 5000; //uodate when your location has changed by 5km
    
    
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
    
    [mLocationManager startMonitoringSignificantLocationChanges];
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        mLongitude.text = [NSString stringWithFormat:@"Long: %.8f", currentLocation.coordinate.longitude];
        mLatitude.text = [NSString stringWithFormat:@"Lat: %.8f", currentLocation.coordinate.latitude];
        [mLocationManager stopUpdatingLocation];
        
        RestClient* weatherAPI = [[RestClient alloc] init];
        [weatherAPI getWeatherAtLocation:currentLocation WithCallback:^(JSBaseClass *jsonObject, NSError *error) {
            if(error != nil) {
                NSLog(@"error");
                [self onError];
            } else {
                NSLog(@"success");
                [self onSuccess:jsonObject];
            }
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API handling

- (void)onError {

    NSAssert([NSThread isMainThread], @"Method called on non UI thread");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    
}

- (void)onSuccess:(JSBaseClass*) baseObject {
    self.mTemperature.text = [NSString stringWithFormat:@"%.0f℃", baseObject.main.temp];
    JSWeather* weather = [baseObject.weather objectAtIndex:0];
    self.mConditions.text = weather.weatherDescription;
    
    NSString* icon = weather.icon;
    
    NSString* url = [NSString stringWithFormat: @"http://openweathermap.org/img/w/%@.png", icon];
    [ViewController getImage:url Into:self.mWeatherIcon];
}

+(void)getImage:(NSString*)url Into:(UIImageView*)imageView {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        //runs on background thread
        NSData* dataFromUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = [UIImage imageWithData: dataFromUrl];
        });
    });
}

@end
