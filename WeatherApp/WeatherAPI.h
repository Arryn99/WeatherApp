//
//  RestCall.h
//  WeatherApp
//
//  Created by Stephanie Schiniou on 16/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DataModels.h"

@protocol WeatherAPI <NSObject>

@required
-(void) getWeatherAtLocation: (CLLocation*)currentLocation WithCallback:(void(^)(JSCurrentWeatherResponse *, NSError*))callback;

-(void) get7DayWeatherAtLocation: (CLLocation*)currentLocation WithCallback:(void(^)(JSBaseClass*, NSError*))callback;

@end
