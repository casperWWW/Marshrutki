//
//  RouteFacade.h
//  Marshrutki
//
//  Created by casperWWW on 12.02.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface RouteFacade : NSObject

+(RouteFacade*)sharedObject;

-(Route*)fetchRouteById:(int)routeId error:(NSError **)error;
-(NSArray*)fetchAll;
-(NSArray*)fetchAllIds;
-(void)removeAllRoutes;

@end
