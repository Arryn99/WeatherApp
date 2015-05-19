//
//  JSList.h
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSTemp;

@interface JSList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double clouds;
@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double rain;
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) double dt;
@property (nonatomic, assign) double pressure;
@property (nonatomic, strong) JSTemp *temp;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, assign) double deg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
