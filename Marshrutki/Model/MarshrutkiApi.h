//
//  MarshrutkiApi.h
//  Marshrutki
//
//  Created by casperWWW on 29.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarshrutkiApi : NSObject

+(MarshrutkiApi*)sharedClient;

-(void)getRoutes:(void (^)(NSArray*, NSError*))block params:(NSDictionary*)params;

@end
