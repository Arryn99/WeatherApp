//
//  JSSys.m
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSSys.h"


NSString *const kJSSysMessage = @"message";
NSString *const kJSSysCountry = @"country";
NSString *const kJSSysSunset = @"sunset";
NSString *const kJSSysSunrise = @"sunrise";


@interface JSSys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSSys

@synthesize message = _message;
@synthesize country = _country;
@synthesize sunset = _sunset;
@synthesize sunrise = _sunrise;


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
            self.message = [[self objectOrNilForKey:kJSSysMessage fromDictionary:dict] doubleValue];
            self.country = [self objectOrNilForKey:kJSSysCountry fromDictionary:dict];
            self.sunset = [[self objectOrNilForKey:kJSSysSunset fromDictionary:dict] doubleValue];
            self.sunrise = [[self objectOrNilForKey:kJSSysSunrise fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kJSSysMessage];
    [mutableDict setValue:self.country forKey:kJSSysCountry];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunset] forKey:kJSSysSunset];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunrise] forKey:kJSSysSunrise];

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

    self.message = [aDecoder decodeDoubleForKey:kJSSysMessage];
    self.country = [aDecoder decodeObjectForKey:kJSSysCountry];
    self.sunset = [aDecoder decodeDoubleForKey:kJSSysSunset];
    self.sunrise = [aDecoder decodeDoubleForKey:kJSSysSunrise];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_message forKey:kJSSysMessage];
    [aCoder encodeObject:_country forKey:kJSSysCountry];
    [aCoder encodeDouble:_sunset forKey:kJSSysSunset];
    [aCoder encodeDouble:_sunrise forKey:kJSSysSunrise];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSSys *copy = [[JSSys alloc] init];
    
    if (copy) {

        copy.message = self.message;
        copy.country = [self.country copyWithZone:zone];
        copy.sunset = self.sunset;
        copy.sunrise = self.sunrise;
    }
    
    return copy;
}


@end
