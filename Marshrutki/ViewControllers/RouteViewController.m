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
    // Send message that route has been changed
    [[NSNotificationCenter defaultCenter] postNotificationName:ROUTE_HASE_BEEN_CHANGED_EVENT
                                                        object:self.routes[indexPath.row]
     ];
    
    // Get map view controller and route view controller
    MySidePanelController* mySidePanelController = (MySidePanelController*) self.parentViewController;
    
    // Show map view controller
    [mySidePanelController showCenterPanelAnimated:YES];
}

@end
