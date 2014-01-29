//
//  RouteDetailViewController.m
//  Marshrutki
//
//  Created by casperWWW on 29.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "RouteDetailViewController.h"
#import "Route.h"

@interface RouteDetailViewController ()

@property (weak, nonatomic) Route* route;
@property (weak, nonatomic) IBOutlet UILabel *routeDescription;

@end

@implementation RouteDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
