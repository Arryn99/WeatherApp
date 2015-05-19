//
//  JSBaseClass.h
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSWind, JSClouds, JSCoord, JSMain, JSSys;

@interface JSCurrentWeatherResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) JSWind *wind;
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) JSClouds *clouds;
@property (nonatomic, strong) JSCoord *coord;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double dt;
@property (nonatomic, assign) double cod;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) JSMain *main;
@property (nonatomic, strong) JSSys *sys;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
