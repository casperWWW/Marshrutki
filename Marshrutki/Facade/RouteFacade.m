//
//  RouteFacade.m
//  Marshrutki
//
//  Created by casperWWW on 12.02.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "RouteFacade.h"
#import "Repository.h"
#import <CoreData/CoreData.h>

@interface RouteFacade ()

@property(strong, nonatomic) NSEntityDescription *routeEntity;
@property(strong, nonatomic) Repository *repository;

@end

@implementation RouteFacade

+(RouteFacade *)sharedObject
{
    static RouteFacade *_sharedObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedObject = [[RouteFacade alloc] init];
    });
    
    return _sharedObject;
}

-(NSEntityDescription *)routeEntity
{
    if (_routeEntity != nil) {
        return _routeEntity;
    }
    
    _routeEntity = [NSEntityDescription entityForName:ROUTE_ENTITY inManagedObjectContext:self.repository.managedObjectContext];
    
    return _routeEntity;
}

-(Repository *)repository
{
    if (_repository != nil) {
        return _repository;
    }
    
    _repository = [Repository sharedObject];
    
    return _repository;
}

#pragma mark - Route's methods

-(NSArray *)fetchAll
{
    NSFetchRequest *allRoutesRequest = [[NSFetchRequest alloc] init];
    [allRoutesRequest setEntity:self.routeEntity];
    
    NSSortDescriptor *sortByFavoritesDescriptor = [[NSSortDescriptor alloc] initWithKey:ROUTE_IS_FAVORITE_FIELD ascending:NO];
    [allRoutesRequest setSortDescriptors:@[sortByFavoritesDescriptor]];
    
    NSError *error = nil;
    NSArray *routes = [self.repository.managedObjectContext executeFetchRequest:allRoutesRequest error:&error];
    
    return routes;
}

-(NSArray *)fetchAllIds
{
    NSFetchRequest *allRouteIdsRequest = [[NSFetchRequest alloc] init];
    [allRouteIdsRequest setEntity:self.routeEntity];
    [allRouteIdsRequest setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *routeIds = [self.repository.managedObjectContext executeFetchRequest:allRouteIdsRequest error:&error];
    
    return routeIds;
}

-(void)removeAllRoutes
{
    NSArray *routes = [self fetchAllIds];
    for (NSManagedObject *route in routes) {
        [self.repository.managedObjectContext deleteObject:route];
    }
    NSError *error = nil;
    [self.repository.managedObjectContext save:&error];
}

-(void)updateRoutes:(NSArray*)routes
{
    // Get all routes from storage
    
}

@end
