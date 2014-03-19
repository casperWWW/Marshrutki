//
//  AppDelegate.h
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *authNavigationController;

- (void)presentLoginViewController;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

@end
