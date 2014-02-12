//
//  Route.m
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "Route.h"
#import "Repository.h"
#import <CoreData/CoreData.h>

@implementation Route

@dynamic routeId, name, price, routeDescription, isFavorite;

+(Route *)routeWithDictionary:(NSDictionary *)routeDictionary
{
    Repository *repository = [Repository sharedObject];
    Route* route = [[Route alloc] initWithEntity:[NSEntityDescription entityForName:ROUTE_ENTITY inManagedObjectContext:repository.managedObjectContext] insertIntoManagedObjectContext:repository.managedObjectContext];
    
    route.routeId = [NSNumber numberWithInt:[routeDictionary[@"route_id"] integerValue]];
    route.name = routeDictionary[@"route_title"];
    route.routeDescription = routeDictionary[@"route_description"];
    route.price = [routeDictionary[@"route_price"] floatValue];
    
    return route;
}

@end
