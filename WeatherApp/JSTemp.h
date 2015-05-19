//
//  JSTemp.h
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JSTemp : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double night;
@property (nonatomic, assign) double min;
@property (nonatomic, assign) double eve;
@property (nonatomic, assign) double day;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double morn;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
