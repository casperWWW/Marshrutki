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

@property(strong, nonatomic) UIBarButtonItem* favoriteBarButton;

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
                                                 name:ROUTE_HAS_BEEN_CHANGED_EVENT
                                               object:nil
     ];
    
    // Add favorite button to the navigation bar
    self.favoriteBarButton = [[UIBarButtonItem alloc] initWithTitle:ADD_TO_FAVORITE_STAR style:UIBarButtonItemStyleBordered target:self action:@selector(favoriteAction)];
    self.navigationItem.rightBarButtonItem = self.favoriteBarButton;
    
    if (self.currentRoute == nil) {
        self.favoriteBarButton.enabled = NO;
    } else {
        [self refreshFavoriteBarButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - map actions
-(void)showCurrentRoute
{
    self.title = self.currentRoute.name;
    NSLog(@"Show route with name %@ on the map", self.currentRoute.name);
}


#pragma mark - Event handlers
-(void)routeChangedNotification:(NSNotification *)notification
{
    Route* chosenRoute = (Route*) [notification object];
    self.currentRoute = chosenRoute;
    [self showCurrentRoute];
    
    // Enable favorite bar button and refresh the text
    self.favoriteBarButton.enabled = YES;
    [self refreshFavoriteBarButton];
}

-(void)favoriteAction
{
    if (self.currentRoute != nil) {
        self.currentRoute.isFavorite = !self.currentRoute.isFavorite;
        [self refreshFavoriteBarButton];
        
        // Send event to add current route to favorites
        [[NSNotificationCenter defaultCenter] postNotificationName:ROUTE_ADD_TO_FAVORITES_EVENT
                                                            object:self.currentRoute
         ];
    }
}

-(void)refreshFavoriteBarButton
{
    self.favoriteBarButton.title = self.currentRoute.isFavorite ? REMOVE_FROM_FAVORITE_STAR : ADD_TO_FAVORITE_STAR;
}

-(void)dealloc
{
    // Clear notification center
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
