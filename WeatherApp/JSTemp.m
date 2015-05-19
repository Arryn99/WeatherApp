//
//  JSTemp.m
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSTemp.h"


NSString *const kJSTempNight = @"night";
NSString *const kJSTempMin = @"min";
NSString *const kJSTempEve = @"eve";
NSString *const kJSTempDay = @"day";
NSString *const kJSTempMax = @"max";
NSString *const kJSTempMorn = @"morn";


@interface JSTemp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSTemp

@synthesize night = _night;
@synthesize min = _min;
@synthesize eve = _eve;
@synthesize day = _day;
@synthesize max = _max;
@synthesize morn = _morn;


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
            self.night = [[self objectOrNilForKey:kJSTempNight fromDictionary:dict] doubleValue];
            self.min = [[self objectOrNilForKey:kJSTempMin fromDictionary:dict] doubleValue];
            self.eve = [[self objectOrNilForKey:kJSTempEve fromDictionary:dict] doubleValue];
            self.day = [[self objectOrNilForKey:kJSTempDay fromDictionary:dict] doubleValue];
            self.max = [[self objectOrNilForKey:kJSTempMax fromDictionary:dict] doubleValue];
            self.morn = [[self objectOrNilForKey:kJSTempMorn fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.night] forKey:kJSTempNight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.min] forKey:kJSTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eve] forKey:kJSTempEve];
    [mutableDict setValue:[NSNumber numberWithDouble:self.day] forKey:kJSTempDay];
    [mutableDict setValue:[NSNumber numberWithDouble:self.max] forKey:kJSTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.morn] forKey:kJSTempMorn];

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

    self.night = [aDecoder decodeDoubleForKey:kJSTempNight];
    self.min = [aDecoder decodeDoubleForKey:kJSTempMin];
    self.eve = [aDecoder decodeDoubleForKey:kJSTempEve];
    self.day = [aDecoder decodeDoubleForKey:kJSTempDay];
    self.max = [aDecoder decodeDoubleForKey:kJSTempMax];
    self.morn = [aDecoder decodeDoubleForKey:kJSTempMorn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_night forKey:kJSTempNight];
    [aCoder encodeDouble:_min forKey:kJSTempMin];
    [aCoder encodeDouble:_eve forKey:kJSTempEve];
    [aCoder encodeDouble:_day forKey:kJSTempDay];
    [aCoder encodeDouble:_max forKey:kJSTempMax];
    [aCoder encodeDouble:_morn forKey:kJSTempMorn];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSTemp *copy = [[JSTemp alloc] init];
    
    if (copy) {

        copy.night = self.night;
        copy.min = self.min;
        copy.eve = self.eve;
        copy.day = self.day;
        copy.max = self.max;
        copy.morn = self.morn;
    }
    
    return copy;
}


@end
