//
//  Repository.h
//  Marshrutki
//
//  Created by casperWWW on 11.02.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Repository : NSObject

@property(nonatomic, strong) NSManagedObjectContext* managedObjectContext;

+(Repository*)sharedObject;

@end
