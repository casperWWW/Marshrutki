//
//  RouteViewController.m
//  Marshrutki
//
//  Created by casperWWW on 26.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "RouteViewController.h"
#import "MapViewController.h"
#import "MySidePanelController.h"
#import "Route.h"
#import "MarshrutkiApi.h"
#import "Repository.h"
#import "RouteFacade.h"

#import <MBProgressHUD.h>

@interface RouteViewController ()

@property(strong, nonatomic) NSArray* routes;

@end

@implementation RouteViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Cusomize styles
    self.tableView.backgroundColor = MENU_BACKGROUND_COLOR;
    UIView* tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    tableHeaderView.backgroundColor = MENU_BACKGROUND_COLOR;
    self.tableView.tableHeaderView = tableHeaderView;
    
    // Check if we should refresh routes by API-request
    RouteFacade *routeFacade = [RouteFacade sharedObject];
    self.routes = [routeFacade fetchAll];
    [self.tableView reloadData];
        // Initialize a preloader
    MBProgressHUD* routesPreloader = self.routes.count ? nil : [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];

    // Create weak link for self to avoid memory leak
    __weak typeof(self) wself = self;
        
    // Load routes, save them and display in table view
    MarshrutkiApi* marshrutkiApi = [MarshrutkiApi sharedClient];
    
    [marshrutkiApi getRoutes:^(NSArray* routes, NSError* error){
        if (error == nil) {
            // Sort routes
            NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:ROUTE_NAME_FIELD ascending:YES selector:@selector(localizedStandardCompare:)];
            NSSortDescriptor *favoriteSort = [[NSSortDescriptor alloc] initWithKey:ROUTE_IS_FAVORITE_FIELD ascending:NO];

            wself.routes = [routes sortedArrayUsingDescriptors:@[favoriteSort, nameSort]];
            [wself.tableView reloadData];
        }
        // Hide preloader
        [routesPreloader hide:YES];
    } params:nil];
    
    // Add event subscriber for "route changed" event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(routeAddedToFavoritesNotification:)
                                                 name:ROUTE_ADD_TO_FAVORITES_EVENT
                                               object:nil
     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.routes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaultCellIdentifier = @"RouteCell";
    static NSString *favoriteCellIdentifier = @"FavoriteRouteCell";
    
    Route* route = nil;
    route = (Route*) [self.routes objectAtIndex:indexPath.row];
    
    NSString* cellIdentifier = defaultCellIdentifier;
    if (route.isFavorite) {
        cellIdentifier = favoriteCellIdentifier;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = route.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", route.price];
    
    return cell;
}

#pragma mark - Table view data actions

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Route* route = nil;
    route = self.routes[indexPath.row];
    
    // Send message that route has been changed
    [[NSNotificationCenter defaultCenter] postNotificationName:ROUTE_HAS_BEEN_CHANGED_EVENT
                                                        object:route
     ];
    
    // Get map view controller and route view controller
    MySidePanelController* mySidePanelController = (MySidePanelController*) self.parentViewController;
    
    // Show map view controller
    [mySidePanelController showCenterPanelAnimated:YES];
}

#pragma mark - Event handlers

-(void)routeAddedToFavoritesNotification:(NSNotification *)notification
{
    // Sort routes - favorites should be on the top
    self.routes = [self.routes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Route* firstRoute = (Route*) obj1;
        Route* secondRoute = (Route*) obj2;
        
        if (firstRoute.isFavorite && !secondRoute.isFavorite) {
            return -1;
        } else if (!firstRoute.isFavorite && secondRoute.isFavorite) {
            return 1;
        } else {
            return 0;
        }
    }];
    [self saveRoutesToRepository];
    
    [self.tableView reloadData];
}

-(void)saveRoutesToRepository
{
    Repository* repository = [Repository sharedObject];
    NSError* error = nil;
    [repository.managedObjectContext save:&error];
}

-(void)dealloc
{
    // Clear notification center
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
