//
//  Route.m
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "Route.h"

@implementation Route

+(Route *)routeWithDictionary:(NSDictionary *)routeDictionary
{
    Route* route = [[Route alloc] init];
    
    route.name = routeDictionary[@"route_title"];
    
    return route;
}

@end
