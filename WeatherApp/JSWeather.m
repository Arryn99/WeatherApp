//
//  JSWeather.m
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSWeather.h"


NSString *const kJSWeatherId = @"id";
NSString *const kJSWeatherMain = @"main";
NSString *const kJSWeatherIcon = @"icon";
NSString *const kJSWeatherDescription = @"description";


@interface JSWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSWeather

@synthesize weatherIdentifier = _weatherIdentifier;
@synthesize main = _main;
@synthesize icon = _icon;
@synthesize weatherDescription = _weatherDescription;


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
            self.weatherIdentifier = [[self objectOrNilForKey:kJSWeatherId fromDictionary:dict] doubleValue];
            self.main = [self objectOrNilForKey:kJSWeatherMain fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kJSWeatherIcon fromDictionary:dict];
            self.weatherDescription = [self objectOrNilForKey:kJSWeatherDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weatherIdentifier] forKey:kJSWeatherId];
    [mutableDict setValue:self.main forKey:kJSWeatherMain];
    [mutableDict setValue:self.icon forKey:kJSWeatherIcon];
    [mutableDict setValue:self.weatherDescription forKey:kJSWeatherDescription];

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

    self.weatherIdentifier = [aDecoder decodeDoubleForKey:kJSWeatherId];
    self.main = [aDecoder decodeObjectForKey:kJSWeatherMain];
    self.icon = [aDecoder decodeObjectForKey:kJSWeatherIcon];
    self.weatherDescription = [aDecoder decodeObjectForKey:kJSWeatherDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_weatherIdentifier forKey:kJSWeatherId];
    [aCoder encodeObject:_main forKey:kJSWeatherMain];
    [aCoder encodeObject:_icon forKey:kJSWeatherIcon];
    [aCoder encodeObject:_weatherDescription forKey:kJSWeatherDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSWeather *copy = [[JSWeather alloc] init];
    
    if (copy) {

        copy.weatherIdentifier = self.weatherIdentifier;
        copy.main = [self.main copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.weatherDescription = [self.weatherDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
