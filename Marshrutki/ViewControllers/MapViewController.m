//
//  MapViewController.m
//  Marshrutki
//
//  Created by casperWWW on 22.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Show authorization controller if user is not logged in
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate presentLoginViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture recognations
- (IBAction)mapLongPressed:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Image has been long pressed!");
    }
}

#pragma mark - map actions
-(void)showCurrentRoute
{
    self.title = self.currentRoute.name;
    NSLog(@"Show route with name %@ on the map", self.currentRoute.name);
}

@end
