//
//  ViewController.m
//  Marshrutki
//
//  Created by casperWWW on 19.01.14.
//  Copyright (c) 2014 casperWWW. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

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
    [self didLoggedIn];
}
- (IBAction)facebookLoginAction:(UIButton *)sender {
    // If the session state is any of the two "open" states when the button is clicked
    if ((FBSession.activeSession.state == FBSessionStateOpen) || (FBSession.activeSession.state == FBSessionStateOpenTokenExtended)) {
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        // Ничего на самом деле не делаем, потому что нам не надо выходить из фэйсбука по клику на этой ссылке
//        [FBSession.activeSession closeAndClearTokenInformation];
        // Делать скрытие страницы логина
        [self didLoggedIn];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Create weak link for self to avoid memory leak
        __weak typeof(self) wself = self;
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Hide login controller
             [wself didLoggedIn];
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
}

-(void)didLoggedIn
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
