//
//  RestClient.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 16/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient


-(void) getWeatherAtLocation: (CLLocation*)currentLocation WithCallback:(void(^)(JSBaseClass*, NSError*))callback {
    
    NSString* url = @"http://api.openweathermap.org/data/2.5/weather?units=metric&";
    NSString* parameters = [NSString stringWithFormat:@"lat=%f&lon=%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [RestClient asyncWebCall:url WithParameters:parameters WithCallback:^(id object, NSError* error) {
        if(error == nil)
        {
            if([object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *parsedJSON = (NSDictionary*) object;
                JSBaseClass* jsonObject = [[JSBaseClass alloc]initWithDictionary:parsedJSON];
                callback(jsonObject, nil);
            }
        } else {
            callback(nil, error);
        }
    }];
}


-(void) getWeatherAtLocation: (CLLocation*)currentLocation AtTime:(NSDate*) date WithCallback:(void(^)(NSDictionary*, NSError*))callback {
    
}

+(NSData*) webCall: (NSString*)url WithParameters: (NSString*)parameters {
    NSString* completeURL = [url stringByAppendingString:parameters];
    return [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: completeURL]];
}

+(void) asyncWebCall: (NSString*)url WithParameters: (NSString*)parameters WithCallback:(void(^)(id, NSError*))callback {
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData* data = [RestClient webCall:url WithParameters:parameters];
        
        NSError *error = nil;
        id object = nil;
        
        if (data == nil) {
            error = [[NSError alloc]initWithDomain:@"Error connecting to server" code:-1 userInfo:nil];
        } else {
            //parse json
            object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
                callback(object, error);
        });
    });
}

@end
