//
//  User.m
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "User.h"

@implementation User

# pragma mark - User factories
+(User *)userWithName:(NSString *)username andPassword:(NSString *)password
{
    User *user = [[User alloc] init];
    
    user.username = username;
    user.password = password;
    
    return user;
}

@end
