//
//  JSCity.m
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSCity.h"
#import "JSCoord.h"


NSString *const kJSCityId = @"id";
NSString *const kJSCityCoord = @"coord";
NSString *const kJSCityCountry = @"country";
NSString *const kJSCityName = @"name";
NSString *const kJSCityPopulation = @"population";


@interface JSCity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSCity

@synthesize cityIdentifier = _cityIdentifier;
@synthesize coord = _coord;
@synthesize country = _country;
@synthesize name = _name;
@synthesize population = _population;


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
            self.cityIdentifier = [[self objectOrNilForKey:kJSCityId fromDictionary:dict] doubleValue];
            self.coord = [JSCoord modelObjectWithDictionary:[dict objectForKey:kJSCityCoord]];
            self.country = [self objectOrNilForKey:kJSCityCountry fromDictionary:dict];
            self.name = [self objectOrNilForKey:kJSCityName fromDictionary:dict];
            self.population = [[self objectOrNilForKey:kJSCityPopulation fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityIdentifier] forKey:kJSCityId];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kJSCityCoord];
    [mutableDict setValue:self.country forKey:kJSCityCountry];
    [mutableDict setValue:self.name forKey:kJSCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.population] forKey:kJSCityPopulation];

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

    self.cityIdentifier = [aDecoder decodeDoubleForKey:kJSCityId];
    self.coord = [aDecoder decodeObjectForKey:kJSCityCoord];
    self.country = [aDecoder decodeObjectForKey:kJSCityCountry];
    self.name = [aDecoder decodeObjectForKey:kJSCityName];
    self.population = [aDecoder decodeDoubleForKey:kJSCityPopulation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_cityIdentifier forKey:kJSCityId];
    [aCoder encodeObject:_coord forKey:kJSCityCoord];
    [aCoder encodeObject:_country forKey:kJSCityCountry];
    [aCoder encodeObject:_name forKey:kJSCityName];
    [aCoder encodeDouble:_population forKey:kJSCityPopulation];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSCity *copy = [[JSCity alloc] init];
    
    if (copy) {

        copy.cityIdentifier = self.cityIdentifier;
        copy.coord = [self.coord copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.population = self.population;
    }
    
    return copy;
}


@end
