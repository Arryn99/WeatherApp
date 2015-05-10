//
//  ViewController.h
//  WeatherApp
//
//  Created by Stephanie Schiniou on 09/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate> {
    CLLocationManager *mLocationManager;
    
}


@end

