//
//  JSBaseClass.m
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSBaseClass.h"
#import "JSWind.h"
#import "JSClouds.h"
#import "JSCoord.h"
#import "JSWeather.h"
#import "JSMain.h"
#import "JSSys.h"


NSString *const kJSBaseClassWind = @"wind";
NSString *const kJSBaseClassBase = @"base";
NSString *const kJSBaseClassClouds = @"clouds";
NSString *const kJSBaseClassCoord = @"coord";
NSString *const kJSBaseClassId = @"id";
NSString *const kJSBaseClassDt = @"dt";
NSString *const kJSBaseClassCod = @"cod";
NSString *const kJSBaseClassWeather = @"weather";
NSString *const kJSBaseClassMain = @"main";
NSString *const kJSBaseClassSys = @"sys";
NSString *const kJSBaseClassName = @"name";


@interface JSBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSBaseClass

@synthesize wind = _wind;
@synthesize base = _base;
@synthesize clouds = _clouds;
@synthesize coord = _coord;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dt = _dt;
@synthesize cod = _cod;
@synthesize weather = _weather;
@synthesize main = _main;
@synthesize sys = _sys;
@synthesize name = _name;


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
            self.wind = [JSWind modelObjectWithDictionary:[dict objectForKey:kJSBaseClassWind]];
            self.base = [self objectOrNilForKey:kJSBaseClassBase fromDictionary:dict];
            self.clouds = [JSClouds modelObjectWithDictionary:[dict objectForKey:kJSBaseClassClouds]];
            self.coord = [JSCoord modelObjectWithDictionary:[dict objectForKey:kJSBaseClassCoord]];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kJSBaseClassId fromDictionary:dict] doubleValue];
            self.dt = [[self objectOrNilForKey:kJSBaseClassDt fromDictionary:dict] doubleValue];
            self.cod = [[self objectOrNilForKey:kJSBaseClassCod fromDictionary:dict] doubleValue];
    NSObject *receivedJSWeather = [dict objectForKey:kJSBaseClassWeather];
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
            self.main = [JSMain modelObjectWithDictionary:[dict objectForKey:kJSBaseClassMain]];
            self.sys = [JSSys modelObjectWithDictionary:[dict objectForKey:kJSBaseClassSys]];
            self.name = [self objectOrNilForKey:kJSBaseClassName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kJSBaseClassWind];
    [mutableDict setValue:self.base forKey:kJSBaseClassBase];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kJSBaseClassClouds];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kJSBaseClassCoord];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kJSBaseClassId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kJSBaseClassDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cod] forKey:kJSBaseClassCod];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kJSBaseClassWeather];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kJSBaseClassMain];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kJSBaseClassSys];
    [mutableDict setValue:self.name forKey:kJSBaseClassName];

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

    self.wind = [aDecoder decodeObjectForKey:kJSBaseClassWind];
    self.base = [aDecoder decodeObjectForKey:kJSBaseClassBase];
    self.clouds = [aDecoder decodeObjectForKey:kJSBaseClassClouds];
    self.coord = [aDecoder decodeObjectForKey:kJSBaseClassCoord];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kJSBaseClassId];
    self.dt = [aDecoder decodeDoubleForKey:kJSBaseClassDt];
    self.cod = [aDecoder decodeDoubleForKey:kJSBaseClassCod];
    self.weather = [aDecoder decodeObjectForKey:kJSBaseClassWeather];
    self.main = [aDecoder decodeObjectForKey:kJSBaseClassMain];
    self.sys = [aDecoder decodeObjectForKey:kJSBaseClassSys];
    self.name = [aDecoder decodeObjectForKey:kJSBaseClassName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wind forKey:kJSBaseClassWind];
    [aCoder encodeObject:_base forKey:kJSBaseClassBase];
    [aCoder encodeObject:_clouds forKey:kJSBaseClassClouds];
    [aCoder encodeObject:_coord forKey:kJSBaseClassCoord];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kJSBaseClassId];
    [aCoder encodeDouble:_dt forKey:kJSBaseClassDt];
    [aCoder encodeDouble:_cod forKey:kJSBaseClassCod];
    [aCoder encodeObject:_weather forKey:kJSBaseClassWeather];
    [aCoder encodeObject:_main forKey:kJSBaseClassMain];
    [aCoder encodeObject:_sys forKey:kJSBaseClassSys];
    [aCoder encodeObject:_name forKey:kJSBaseClassName];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSBaseClass *copy = [[JSBaseClass alloc] init];
    
    if (copy) {

        copy.wind = [self.wind copyWithZone:zone];
        copy.base = [self.base copyWithZone:zone];
        copy.clouds = [self.clouds copyWithZone:zone];
        copy.coord = [self.coord copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.dt = self.dt;
        copy.cod = self.cod;
        copy.weather = [self.weather copyWithZone:zone];
        copy.main = [self.main copyWithZone:zone];
        copy.sys = [self.sys copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
