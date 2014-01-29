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

#import <MBProgressHUD.h>

@interface RouteViewController ()

@property(strong, nonatomic) NSArray* routes;
@property(strong, nonatomic) NSMutableArray* favoriteRoutes;

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
    
    // Initialize favorites
    self.favoriteRoutes = [[NSMutableArray alloc] init];
    
    // Initialize a preloader
    MBProgressHUD* routesPreloader = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    routesPreloader.labelText = @"Loading";
    
    // Create weak link for self to avoid memory leak
    __weak typeof(self) wself = self;
    
    // Load routes, save them and display in table view
    MarshrutkiApi* marshrutkiApi = [MarshrutkiApi sharedClient];
    [marshrutkiApi getRoutes:^(NSArray* routes, NSError* error){
        wself.routes = routes;
        [wself.tableView reloadData];
        
        // Hide preloader
        routesPreloader.hidden = YES;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.favoriteRoutes.count;
    }
    
    return self.routes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RouteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Route* route = nil;
    if (indexPath.section == 1) {
        route = (Route*) [self.favoriteRoutes objectAtIndex:indexPath.row];
    } else {
        route = (Route*) [self.routes objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = route.name;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (self.favoriteRoutes.count > 0) {
            return @"Favorites";
        } else {
            return nil;
        }
    }
    
    return @"Routes";
}


#pragma mark - Table view data actions

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Route* route = nil;
    if (indexPath.section == 1) {
        route = self.favoriteRoutes[indexPath.row];
    } else {
        route = self.routes[indexPath.row];
    }
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
    Route* route = (Route*) notification.object;
    if (! [self.favoriteRoutes containsObject:route]) {
        [self.favoriteRoutes addObject:route];
        [self.tableView reloadData];
    }
}

-(void)dealloc
{
    // Clear notification center
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
