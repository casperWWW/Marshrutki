//
//  MapViewController.h
//  Marshrutki
//
//  Created by casperWWW on 22.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface MapViewController : UIViewController

@property(strong, nonatomic)Route* currentRoute;

-(void)showCurrentRoute;

@end
