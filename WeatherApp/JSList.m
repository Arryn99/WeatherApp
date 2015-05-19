//
//  JSList.m
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSList.h"
#import "JSTemp.h"
#import "JSWeather.h"


NSString *const kJSListClouds = @"clouds";
NSString *const kJSListHumidity = @"humidity";
NSString *const kJSListRain = @"rain";
NSString *const kJSListSpeed = @"speed";
NSString *const kJSListDt = @"dt";
NSString *const kJSListPressure = @"pressure";
NSString *const kJSListTemp = @"temp";
NSString *const kJSListWeather = @"weather";
NSString *const kJSListDeg = @"deg";


@interface JSList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSList

@synthesize clouds = _clouds;
@synthesize humidity = _humidity;
@synthesize rain = _rain;
@synthesize speed = _speed;
@synthesize dt = _dt;
@synthesize pressure = _pressure;
@synthesize temp = _temp;
@synthesize weather = _weather;
@synthesize deg = _deg;


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
            self.clouds = [[self objectOrNilForKey:kJSListClouds fromDictionary:dict] doubleValue];
            self.humidity = [[self objectOrNilForKey:kJSListHumidity fromDictionary:dict] doubleValue];
            self.rain = [[self objectOrNilForKey:kJSListRain fromDictionary:dict] doubleValue];
            self.speed = [[self objectOrNilForKey:kJSListSpeed fromDictionary:dict] doubleValue];
            self.dt = [[self objectOrNilForKey:kJSListDt fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kJSListPressure fromDictionary:dict] doubleValue];
            self.temp = [JSTemp modelObjectWithDictionary:[dict objectForKey:kJSListTemp]];
    NSObject *receivedJSWeather = [dict objectForKey:kJSListWeather];
    NSMutableArray *parsedJSWeather = [NSMutableArray array];
    if ([receivedJSWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedJSWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedJSWeather addObject:[JSWeather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedJSWeather isKindOfClass:[NSDictionary class]]) {
       [parsedJSWeather addObject:[JSWeather modelObjectWithDictionary:(NSDictionary *)receivedJSWeather]];
    }

    self.weather = [NSArray arrayWithArray:parsedJSWeather];
            self.deg = [[self objectOrNilForKey:kJSListDeg fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.clouds] forKey:kJSListClouds];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kJSListHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rain] forKey:kJSListRain];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kJSListSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kJSListDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kJSListPressure];
    [mutableDict setValue:[self.temp dictionaryRepresentation] forKey:kJSListTemp];
    NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kJSListWeather];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kJSListDeg];

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

    self.clouds = [aDecoder decodeDoubleForKey:kJSListClouds];
    self.humidity = [aDecoder decodeDoubleForKey:kJSListHumidity];
    self.rain = [aDecoder decodeDoubleForKey:kJSListRain];
    self.speed = [aDecoder decodeDoubleForKey:kJSListSpeed];
    self.dt = [aDecoder decodeDoubleForKey:kJSListDt];
    self.pressure = [aDecoder decodeDoubleForKey:kJSListPressure];
    self.temp = [aDecoder decodeObjectForKey:kJSListTemp];
    self.weather = [aDecoder decodeObjectForKey:kJSListWeather];
    self.deg = [aDecoder decodeDoubleForKey:kJSListDeg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_clouds forKey:kJSListClouds];
    [aCoder encodeDouble:_humidity forKey:kJSListHumidity];
    [aCoder encodeDouble:_rain forKey:kJSListRain];
    [aCoder encodeDouble:_speed forKey:kJSListSpeed];
    [aCoder encodeDouble:_dt forKey:kJSListDt];
    [aCoder encodeDouble:_pressure forKey:kJSListPressure];
    [aCoder encodeObject:_temp forKey:kJSListTemp];
    [aCoder encodeObject:_weather forKey:kJSListWeather];
    [aCoder encodeDouble:_deg forKey:kJSListDeg];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSList *copy = [[JSList alloc] init];
    
    if (copy) {

        copy.clouds = self.clouds;
        copy.humidity = self.humidity;
        copy.rain = self.rain;
        copy.speed = self.speed;
        copy.dt = self.dt;
        copy.pressure = self.pressure;
        copy.temp = [self.temp copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
