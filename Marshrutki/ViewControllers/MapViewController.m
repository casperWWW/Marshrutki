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
    
    // Add event subscriber for "route changed" event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(routeChangedNotification:)
                                                 name:ROUTE_HASE_BEEN_CHANGED_EVENT
                                               object:nil
     ];
    
    // Hide navigation bar button detail when current route is empty
    if (self.currentRoute == nil) {
//        self.navigationController.navigationItem.rightBarButtonItem.enabled = NO;
    }
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
    self.navigationController.navigationItem.rightBarButtonItem.enabled = YES;
    NSLog(@"Show route with name %@ on the map", self.currentRoute.name);
}

-(void)routeChangedNotification:(NSNotification *)notification
{
    Route* chosenRoute = (Route*) [notification object];
    self.currentRoute = chosenRoute;
    [self showCurrentRoute];
}

-(void)dealloc
{
    // Clear notification center
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
