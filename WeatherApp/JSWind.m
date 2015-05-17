//
//  JSWind.m
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSWind.h"


NSString *const kJSWindSpeed = @"speed";
NSString *const kJSWindDeg = @"deg";


@interface JSWind ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSWind

@synthesize speed = _speed;
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
            self.speed = [[self objectOrNilForKey:kJSWindSpeed fromDictionary:dict] doubleValue];
            self.deg = [[self objectOrNilForKey:kJSWindDeg fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kJSWindSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kJSWindDeg];

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

    self.speed = [aDecoder decodeDoubleForKey:kJSWindSpeed];
    self.deg = [aDecoder decodeDoubleForKey:kJSWindDeg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_speed forKey:kJSWindSpeed];
    [aCoder encodeDouble:_deg forKey:kJSWindDeg];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSWind *copy = [[JSWind alloc] init];
    
    if (copy) {

        copy.speed = self.speed;
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
