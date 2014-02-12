//
//  RouteFacade.h
//  Marshrutki
//
//  Created by casperWWW on 12.02.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteFacade : NSObject

+(RouteFacade*)sharedObject;

-(NSArray*)fetchAll;
-(NSArray*)fetchAllIds;
-(void)removeAllRoutes;
-(void)updateRoutes:(NSArray*)routes;

@end
