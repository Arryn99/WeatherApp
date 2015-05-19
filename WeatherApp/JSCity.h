//
//  JSCity.h
//
//  Created by   on 19/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSCoord;

@interface JSCity : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double cityIdentifier;
@property (nonatomic, strong) JSCoord *coord;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double population;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
