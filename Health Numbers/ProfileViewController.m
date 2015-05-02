//
//  ProfileViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)submitButtonPress:(id)sender {
    [self postToParse];
    NSLog(@"%@", self.userProfile);
}


-(void) postToParse {
    PFObject *userObject = [PFObject objectWithClassName:@"User"];
    userObject[@"facebook_id"] = [self.userProfile objectForKey:@"facebook_id"];
    userObject[@"name"] = [self.userProfile objectForKey:@"first_name"];
    userObject[@"hpv"] = @"false";
    userObject[@"chlamydia"] = @"false";
    userObject[@"gonorrhea"] = @"true";
    userObject[@"hiv"] = @"false";
    userObject[@"other"] = @"true";
    userObject[@"anonymous"] = @"false";
    [userObject saveInBackground];
}

@end
