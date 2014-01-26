//
//  RouteViewController.m
//  Marshrutki
//
//  Created by casperWWW on 26.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "RouteViewController.h"
#import "Route.h"

#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface RouteViewController ()

@property(strong, nonatomic) NSMutableArray* routes;

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
    MBProgressHUD* preloader = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    preloader.labelText = @"Loading";

    // Get data by API call to http://marshrutki.com.ua/mu/routes.php
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://marshrutki.com.ua/mu/routes.php" parameters:nil success:^(AFHTTPRequestOperation* operation, id responseObject) {
        self.routes = [[NSMutableArray alloc] init];
        // Parse json data
        NSArray* rawRoutes = (NSArray*) responseObject;
        for (NSDictionary* rawRoute in rawRoutes) {
            Route *route = [Route routeWithDictionary:rawRoute];
            
            [self.routes addObject:route];
        }
        
        [self.tableView reloadData];
        
        // Hide preloader
        preloader.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error in the API request was ocurred");
        
        // Hide preloader
        preloader.hidden = YES;
    }];
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

@end
