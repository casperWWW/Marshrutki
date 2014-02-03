//
//  Route.h
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *description;
@property (assign, nonatomic) BOOL isFavorite;

+(Route*)routeWithDictionary:(NSDictionary*)routeDictionary;

@end
