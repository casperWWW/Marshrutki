//
//  MarshrutkiApi.h
//  Marshrutki
//
//  Created by casperWWW on 29.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface MarshrutkiApi : NSObject

@property(strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

+(MarshrutkiApi*)sharedClient;

-(void)getRoutes:(void (^)(NSArray*, NSError*))block params:(NSDictionary*)params;

@end
