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
    self.userProfile = @{
                         @"first_name":[user objectForKey:@"first_name"],
                         @"facebook_id":[user objectForKey:@"id"]
                         };
    
    [self checkForDuplicateRecord];
    
}


-(void) checkForDuplicateRecord {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"facebook_id" equalTo:[self.userProfile objectForKey:@"facebook_id"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count > 0) {
//                if an account found, direct to user dashboard
                [self performSegueWithIdentifier:@"openDashboard" sender:self];
            } else {
//                if no user found, open profile registration page
                [self performSegueWithIdentifier:@"openMyProfile" sender:self];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


// This will get called as well before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openMyProfile"]) {
        // Get destination view
        ProfileViewController *vc = [segue destinationViewController];
        vc.userProfile = self.userProfile;
    } else if ([[segue identifier] isEqualToString:@"openDashboard"]) {
        DashboardCollectionViewController *dvc = [segue destinationViewController];
    }
}


- (void) loginViewShowingLoggedInUser:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
}


@end
