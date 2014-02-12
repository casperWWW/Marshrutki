//
//  Repository.m
//  Marshrutki
//
//  Created by casperWWW on 11.02.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "Repository.h"

@interface Repository()

@property(nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property(nonatomic, strong) NSString* persistentStorePath;

@end

@implementation Repository

+(Repository *)sharedObject
{
    static Repository* _sharedObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedObject = [[Repository alloc] init];
    });
    
    return _sharedObject;
}

#pragma mark - Core Data stack setup
-(NSManagedObjectContext*)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL* storeURL = [NSURL fileURLWithPath:self.persistentStorePath];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    NSError* error = nil;
    NSPersistentStore* persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    NSAssert3(persistentStore != nil, @"Unhandled error adding persistent store in %s at line %d: %@", __FUNCTION__, __LINE__, [error localizedDescription]);
    
    return _persistentStoreCoordinator;
}

-(NSString *)persistentStorePath
{
    if (_persistentStorePath != nil) {
        return _persistentStorePath;
    }
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = (NSString*) [paths lastObject];
    _persistentStorePath = [documentsDirectory stringByAppendingPathComponent:@"Marshrutki.sqlite"];
    
    return _persistentStorePath;
}

@end
