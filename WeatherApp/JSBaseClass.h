//
//  JSBaseClass.h
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSCity;

@interface JSBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double message;
@property (nonatomic, strong) NSString *cod;
@property (nonatomic, strong) JSCity *city;
@property (nonatomic, assign) double cnt;
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
