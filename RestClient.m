//
//  RestClient.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 16/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient


-(void) getWeatherAtLocation: (CLLocation*)currentLocation WithCallback:(void(^)(JSCurrentWeatherResponse*, NSError*))callback {
    
    NSString* url = @"http://api.openweathermap.org/data/2.5/weather?units=metric&";
    NSString* parameters = [NSString stringWithFormat:@"lat=%f&lon=%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [RestClient asyncWebCall:url WithParameters:parameters WithCallback:^(NSDictionary* object, NSError* error) {
            callback([[JSCurrentWeatherResponse alloc]initWithDictionary:object], error);
    }];
}


-(void) getWeatherAtLocation: (CLLocation*)currentLocation AtTime:(NSDate*) date WithCallback:(void(^)(JSBaseClass*, NSError*))callback {
    NSString* url = @"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&cnt=7&mode=json";
    NSString* completeURL = [NSString stringWithFormat:url, currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [RestClient asyncWebCall:completeURL WithParameters:nil WithCallback:^(NSDictionary* jsonObject, NSError* error) {
        callback([[JSBaseClass alloc]initWithDictionary:jsonObject], error);
    }];
}

+(NSData*) webCall: (NSString*)url WithParameters: (NSString*)parameters {
    NSString* completeURL = [url stringByAppendingString:parameters];
    return [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: completeURL]];
}

+(void) asyncWebCall: (NSString*)url WithParameters: (NSString*)parameters WithCallback:(void(^)(NSDictionary* dictionary, NSError*))callback {
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData* data = [RestClient webCall:url WithParameters:parameters];
        
        NSError *error = nil;
        NSDictionary *value = nil;
        
        if (data == nil) {
             error = [[NSError alloc]initWithDomain:@"Error connecting to server" code:-1 userInfo:nil];
        } else {
            //parse json
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if([object isKindOfClass:[NSDictionary class]] && error == nil) {
                value = object;
            } else {
                error = [[NSError alloc]initWithDomain:@"webcall did not return dictionary" code:-1 userInfo:nil];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(value, error);
        });
    });
}

@end
