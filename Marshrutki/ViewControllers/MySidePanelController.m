//
//  MySidePanelController.m
//  Marshrutki
//
//  Created by casperWWW on 26.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "MySidePanelController.h"

@interface MySidePanelController ()

@end

@implementation MySidePanelController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"RouteViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"]];
}

@end
