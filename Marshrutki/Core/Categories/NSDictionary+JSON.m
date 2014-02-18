//
//  NSDictionary+JSON.m
//  Marshrutki
//
//  Created by casperWWW on 16.02.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

-(id)jsonObjectForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    
    return object;
}

@end
