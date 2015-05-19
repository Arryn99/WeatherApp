//
//  JSBaseClass.m
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JSBaseClass.h"
#import "JSCity.h"
#import "JSList.h"


NSString *const kJSBaseClassMessage = @"message";
NSString *const kJSBaseClassCod = @"cod";
NSString *const kJSBaseClassCity = @"city";
NSString *const kJSBaseClassCnt = @"cnt";
NSString *const kJSBaseClassList = @"list";


@interface JSBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JSBaseClass

@synthesize message = _message;
@synthesize cod = _cod;
@synthesize city = _city;
@synthesize cnt = _cnt;
@synthesize list = _list;


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
            self.message = [[self objectOrNilForKey:kJSBaseClassMessage fromDictionary:dict] doubleValue];
            self.cod = [self objectOrNilForKey:kJSBaseClassCod fromDictionary:dict];
            self.city = [JSCity modelObjectWithDictionary:[dict objectForKey:kJSBaseClassCity]];
            self.cnt = [[self objectOrNilForKey:kJSBaseClassCnt fromDictionary:dict] doubleValue];
    NSObject *receivedJSList = [dict objectForKey:kJSBaseClassList];
    NSMutableArray *parsedJSList = [NSMutableArray array];
    if ([receivedJSList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedJSList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedJSList addObject:[JSList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedJSList isKindOfClass:[NSDictionary class]]) {
       [parsedJSList addObject:[JSList modelObjectWithDictionary:(NSDictionary *)receivedJSList]];
    }

    self.list = [NSArray arrayWithArray:parsedJSList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kJSBaseClassMessage];
    [mutableDict setValue:self.cod forKey:kJSBaseClassCod];
    [mutableDict setValue:[self.city dictionaryRepresentation] forKey:kJSBaseClassCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kJSBaseClassCnt];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kJSBaseClassList];

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

    self.message = [aDecoder decodeDoubleForKey:kJSBaseClassMessage];
    self.cod = [aDecoder decodeObjectForKey:kJSBaseClassCod];
    self.city = [aDecoder decodeObjectForKey:kJSBaseClassCity];
    self.cnt = [aDecoder decodeDoubleForKey:kJSBaseClassCnt];
    self.list = [aDecoder decodeObjectForKey:kJSBaseClassList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_message forKey:kJSBaseClassMessage];
    [aCoder encodeObject:_cod forKey:kJSBaseClassCod];
    [aCoder encodeObject:_city forKey:kJSBaseClassCity];
    [aCoder encodeDouble:_cnt forKey:kJSBaseClassCnt];
    [aCoder encodeObject:_list forKey:kJSBaseClassList];
}

- (id)copyWithZone:(NSZone *)zone
{
    JSBaseClass *copy = [[JSBaseClass alloc] init];
    
    if (copy) {

        copy.message = self.message;
        copy.cod = [self.cod copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.cnt = self.cnt;
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
