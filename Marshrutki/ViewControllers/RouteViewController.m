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
    
    // Initialize a preloader
    MBProgressHUD* routesPreloader = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    routesPreloader.labelText = @"Loading";
    
    __weak typeof(self) wself = self;
    MarshrutkiApi* marshrutkiApi = [MarshrutkiApi sharedClient];
    [marshrutkiApi getRoutes:^(NSArray* routes, NSError* error){
        wself.routes = routes;
        [wself.tableView reloadData];
        
        // Hide preloader
        routesPreloader.hidden = YES;
    } params:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.routes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RouteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Route* route = (Route*) [self.routes objectAtIndex:indexPath.row];
    cell.textLabel.text = route.name;
    
    return cell;
}

#pragma mark - Table view data actions

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get map view controller and route view controller
    MySidePanelController* mySidePanelController = (MySidePanelController*) self.parentViewController;
    UINavigationController* mainNavigationController = (UINavigationController*) mySidePanelController.centerPanel;
    MapViewController* mapViewController = (MapViewController*) mainNavigationController.topViewController;
    
    // Set current route
    mapViewController.currentRoute = (Route*) self.routes[indexPath.row];
    
    // Show map view controller
    [mySidePanelController showCenterPanelAnimated:YES];
    [mapViewController showCurrentRoute];
}

@end
