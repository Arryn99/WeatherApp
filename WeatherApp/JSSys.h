//
//  JSSys.h
//
//  Created by   on 16/05/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JSSys : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double message;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) double sunset;
@property (nonatomic, assign) double sunrise;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
