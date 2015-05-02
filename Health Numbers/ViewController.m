//
//  ViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self facebookAuthentication];

}

-(void) facebookAuthentication {
    // Facebook Login
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:
                              @[@"public_profile", @"email", @"user_friends"]];
    
    loginView.center = self.view.center;
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

- (void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
//   open my profile if user fb info recieved
    [self performSegueWithIdentifier:@"openMyProfile" sender:self];
}

- (void) loginViewShowingLoggedInUser:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"user signed in");
}


@end
