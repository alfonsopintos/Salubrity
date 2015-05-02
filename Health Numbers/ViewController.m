//
//  ViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
    @property(nonatomic) NSDictionary *userProfile;
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
//    place if/else block here, query parse for facebook_id, if the same, skip segue, otherwise segue to show profile
    self.userProfile = @{
                         @"first_name":[user objectForKey:@"first_name"],
                         @"facebook_id":[user objectForKey:@"id"]
                         };
    [self performSegueWithIdentifier:@"openMyProfile" sender:self];
}


// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openMyProfile"]) {
        // Get destination view
        ProfileViewController *vc = [segue destinationViewController];
        vc.userProfile = self.userProfile;
        
    }
}


- (void) loginViewShowingLoggedInUser:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
}


@end
