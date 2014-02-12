//
//  Route.h
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Route : NSManagedObject

@property (strong, nonatomic) NSNumber *routeId;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) float price;
@property (strong, nonatomic) NSString *routeDescription;
@property (assign, nonatomic) BOOL isFavorite;

+(Route*)routeWithDictionary:(NSDictionary*)routeDictionary;

@end
