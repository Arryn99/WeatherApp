//
//  JSMain.m
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSMain.h"


NSString *const kJSMainHumidity = @"humidity";
NSString *const kJSMainTempMin = @"temp_min";
NSString *const kJSMainTempMax = @"temp_max";
NSString *const kJSMainTemp = @"temp";
NSString *const kJSMainPressure = @"pressure";
NSString *const kJSMainGrndLevel = @"grnd_level";
NSString *const kJSMainSeaLevel = @"sea_level";


@interface JSMain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSMain

@synthesize humidity = _humidity;
@synthesize tempMin = _tempMin;
@synthesize tempMax = _tempMax;
@synthesize temp = _temp;
@synthesize pressure = _pressure;
@synthesize grndLevel = _grndLevel;
@synthesize seaLevel = _seaLevel;


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
            self.humidity = [[self objectOrNilForKey:kJSMainHumidity fromDictionary:dict] doubleValue];
            self.tempMin = [[self objectOrNilForKey:kJSMainTempMin fromDictionary:dict] doubleValue];
            self.tempMax = [[self objectOrNilForKey:kJSMainTempMax fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kJSMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kJSMainPressure fromDictionary:dict] doubleValue];
            self.grndLevel = [[self objectOrNilForKey:kJSMainGrndLevel fromDictionary:dict] doubleValue];
            self.seaLevel = [[self objectOrNilForKey:kJSMainSeaLevel fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kJSMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMin] forKey:kJSMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMax] forKey:kJSMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kJSMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kJSMainPressure];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grndLevel] forKey:kJSMainGrndLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.seaLevel] forKey:kJSMainSeaLevel];

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

    self.humidity = [aDecoder decodeDoubleForKey:kJSMainHumidity];
    self.tempMin = [aDecoder decodeDoubleForKey:kJSMainTempMin];
    self.tempMax = [aDecoder decodeDoubleForKey:kJSMainTempMax];
    self.temp = [aDecoder decodeDoubleForKey:kJSMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kJSMainPressure];
    self.grndLevel = [aDecoder decodeDoubleForKey:kJSMainGrndLevel];
    self.seaLevel = [aDecoder decodeDoubleForKey:kJSMainSeaLevel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kJSMainHumidity];
    [aCoder encodeDouble:_tempMin forKey:kJSMainTempMin];
    [aCoder encodeDouble:_tempMax forKey:kJSMainTempMax];
    [aCoder encodeDouble:_temp forKey:kJSMainTemp];
    [aCoder encodeDouble:_pressure forKey:kJSMainPressure];
    [aCoder encodeDouble:_grndLevel forKey:kJSMainGrndLevel];
    [aCoder encodeDouble:_seaLevel forKey:kJSMainSeaLevel];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSMain *copy = [[JSMain alloc] init];
    
    if (copy) {

        copy.humidity = self.humidity;
        copy.tempMin = self.tempMin;
        copy.tempMax = self.tempMax;
        copy.temp = self.temp;
        copy.pressure = self.pressure;
        copy.grndLevel = self.grndLevel;
        copy.seaLevel = self.seaLevel;
    }
    
    return copy;
}


@end
