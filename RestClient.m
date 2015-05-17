//
//  RestClient.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 16/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient


-(void) getWeatherAtLocation: (CLLocation*)currentLocation WithCallback:(void(^)(JSBaseClass *, NSError*))callback {
    
    NSString* parameters = [NSString stringWithFormat:@"lat=%f&lon=%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    NSString* url = [@"http://api.openweathermap.org/data/2.5/weather?units=metric&" stringByAppendingString: parameters];
    
    //this call is synchronous and takes too long
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url ]];
    NSError *error = nil;
    
    //parse json
    id object = [NSJSONSerialization JSONObjectWithData:allCoursesData options:NSJSONReadingAllowFragments error:&error];
    
    if(error) {
        callback(nil, error);
    }
    else {
        if([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *parsedJSON = (NSDictionary*) object;
            JSBaseClass* jsonObject = [[JSBaseClass alloc]initWithDictionary:parsedJSON];
            callback(jsonObject, nil);
            
        }
    }
}


-(void) getWeatherAtLocation: (CLLocation*)currentLocation AtTime:(NSDate*) date WithCallback:(void(^)(NSDictionary*, NSError*))callback {
    
}

@end
