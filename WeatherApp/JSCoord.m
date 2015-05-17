//
//  JSCoord.m
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSCoord.h"


NSString *const kJSCoordLon = @"lon";
NSString *const kJSCoordLat = @"lat";


@interface JSCoord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSCoord

@synthesize lon = _lon;
@synthesize lat = _lat;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lon = [[self objectOrNilForKey:kJSCoordLon fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kJSCoordLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lon] forKey:kJSCoordLon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kJSCoordLat];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.lon = [aDecoder decodeDoubleForKey:kJSCoordLon];
    self.lat = [aDecoder decodeDoubleForKey:kJSCoordLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lon forKey:kJSCoordLon];
    [aCoder encodeDouble:_lat forKey:kJSCoordLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSCoord *copy = [[JSCoord alloc] init];
    
    if (copy) {

        copy.lon = self.lon;
        copy.lat = self.lat;
    }
    
    return copy;
}


@end
