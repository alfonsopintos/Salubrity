//
//  MeViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/3/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.userProfile);
//    [self fetchProfileInfo];
}


-(void) fetchProfileInfo {

}

- (void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    self.userProfile = @{
                         @"first_name":[user objectForKey:@"first_name"],
                         @"facebook_id":[user objectForKey:@"id"]
                         };
    NSLog(@"%@", self.userProfile);
}

@end
