//
//  JSMain.h
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JSMain : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) double tempMax;
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double pressure;
@property (nonatomic, assign) double grndLevel;
@property (nonatomic, assign) double seaLevel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
