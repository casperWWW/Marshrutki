//
//  ViewController.m
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLogin:(UIButton *)sender
{
    // Try to create user object with specified username and password
    User *user = [User userWithName:self.txtUsername.text andPassword:self.txtPassword.text];
    
    NSLog(@"Login action: username - %@, password - %@", user.username, user.password);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
