//
//  MapViewController.m
//  Marshrutki
//
//  Created by casperWWW on 22.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Show authorization controller if user is not logged in
    UIViewController* loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthNavigationController"];
    [self.navigationController presentViewController:loginViewController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture recognations
- (IBAction)mapLongPressed:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"Image has been long pressed!");
}

#pragma mark - map actions
-(void)showCurrentRoute
{
    NSLog(@"Show route with name %@ on the map", self.currentRoute.name);
}

@end
