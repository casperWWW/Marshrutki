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
#import "RouteFacade.h"

@implementation Route

@dynamic routeId, name, price, routeDescription, isFavorite;

+(Route *)routeWithDictionary:(NSDictionary *)routeDictionary
{
    Repository *repository = [Repository sharedObject];
    int routeId = [routeDictionary[@"route_id"] integerValue];
    
    NSError *error = nil;
    Route *route = [[RouteFacade sharedObject] fetchRouteById:routeId error:&error];
    if (error) {
        return nil;
    } else if(!route) {
        route = [[Route alloc] initWithEntity:[NSEntityDescription entityForName:ROUTE_ENTITY inManagedObjectContext:repository.managedObjectContext] insertIntoManagedObjectContext:repository.managedObjectContext];
        route.routeId = @(routeId); // Like [NSNumber numberWithInt:]
    }
    
    route.name = routeDictionary[@"route_title"];
    route.routeDescription = routeDictionary[@"route_description"];
    route.price = [routeDictionary[@"route_price"] floatValue];
    
    return route;
}

@end
