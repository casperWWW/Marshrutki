//
//  MarshrutkiApi.m
//  Marshrutki
//
//  Created by casperWWW on 29.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "MarshrutkiApi.h"
#import "Route.h"
#import "Repository.h"

@implementation MarshrutkiApi

+(MarshrutkiApi *)sharedClient
{
    static MarshrutkiApi* _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL* baseURL = [[NSURL alloc] initWithString:MUAPI_BASE_URL];
        _sharedClient = [[MarshrutkiApi alloc] init];
        _sharedClient.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

-(void)getRoutes:(void (^)(NSArray*, NSError*))block params:(NSDictionary*)params
{
    void (^successBlock)(AFHTTPRequestOperation* operation, id responseObject) = ^(AFHTTPRequestOperation* operation, id responseObject)
    {
        // Parse json data
        NSArray* rawRoutes = (NSArray*) responseObject;
        NSMutableArray* routes = [[NSMutableArray alloc] init];
        for (NSDictionary* rawRoute in rawRoutes) {
            Route *route = [Route routeWithDictionary:rawRoute];
            
            if (route) {
                [routes addObject:route];
            }
        }
        // Save routes to core data
        Repository* repository = [Repository sharedObject];
        NSError *repositoryError = nil;
        NSAssert1([repository.managedObjectContext save:&repositoryError], @"Can't save routes to storage. Error: %@", [repositoryError description]);
        
        if (block != nil) {
            block(routes, nil);
        }
    };
    
    void (^failureBlock)(AFHTTPRequestOperation* operation, NSError* error) = ^(AFHTTPRequestOperation* operation, NSError* error)
    {
        if (block != nil) {
            block(nil, error);
        }
    };
     
    // Get data by API call to http://marshrutki.com.ua/mu/routes.php
    [self.requestOperationManager GET:MUAPI_ROUTES_URI parameters:nil success:successBlock failure:failureBlock];
}

@end
