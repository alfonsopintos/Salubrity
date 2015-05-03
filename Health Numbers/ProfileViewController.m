//
//  ProfileViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
    @property (nonatomic) PFObject *userProfileObject;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.anonymousSwitch addTarget:self
                      action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
    
    if ([self.title isEqual: @"ME"]) {
        [self fetchUserData];
    }
}


-(void) fetchUserData {
    
    [FBRequestConnection startWithGraphPath:@"/me"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              self.userProfile = result;
                              
                              PFQuery *query = [PFQuery queryWithClassName:@"User"];

                              [query whereKey:@"facebook_id" equalTo:[self.userProfile objectForKey:@"id"]];
                              [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                  if (!error) {
                                      // The find succeeded.
                                      // Do something with the found objects
                                      self.userProfileObject = [objects firstObject];
                                      [self setupSwitches];
                                  } else {
                                      // Log details of the failure
                                      NSLog(@"Error: %@ %@", error, [error userInfo]);
                                  }
                              }];
                              
                              
                          }];

    
}

-(void) setupSwitches {
    NSLog(@"%@", self.userProfileObject);
    if ([[self.userProfileObject objectForKey:@"hpv"] isEqualToString:@"true"]) {
        [self.hpvSwitch setOn:YES animated:YES];
    }
    
//    previous mixup with naming stuck through
    if ([[self.userProfileObject objectForKey:@"herpes"] isEqualToString:@"true"]) {
        [self.chlamydiaSwitch setOn:YES animated:YES];
    }
    
    if ([[self.userProfileObject objectForKey:@"gonorrhea"] isEqualToString:@"true"]) {
        [self.gonorrheaSwitch setOn:YES animated:YES];
    }
    
    if ([[self.userProfileObject objectForKey:@"hiv"] isEqualToString:@"true"]) {
        [self.hivSwitch setOn:YES animated:YES];
    }
    
    if ([[self.userProfileObject objectForKey:@"other"] isEqualToString:@"true"]) {
        [self.otherSwitch setOn:YES animated:YES];
    }
    
}


- (IBAction)submitButtonPress:(id)sender {
    [self postToParse];
}


-(void) postToParse {
    PFObject *userObject = [PFObject objectWithClassName:@"User"];
    userObject[@"facebook_id"] = [self.userProfile objectForKey:@"facebook_id"];
    userObject[@"first_name"] = [self.userProfile objectForKey:@"first_name"];

    if ([self.hpvSwitch isOn]) {
        userObject[@"hpv"] = @"true";
    } else {
        userObject[@"hpv"] = @"false";
    }
    
//    changed from chlamydia to herpes - did not change the button naming
    if ([self.chlamydiaSwitch isOn]) {
        userObject[@"herpes"] = @"true";
    } else {
        userObject[@"herpes"] = @"false";
    }
    
    if ([self.gonorrheaSwitch isOn]) {
        userObject[@"gonorrhea"] = @"true";
    } else {
        userObject[@"gonorrhea"] = @"false";
    }
    
    if ([self.hivSwitch isOn]) {
        userObject[@"hiv"] = @"true";
    } else {
        userObject[@"hiv"] = @"false";
    }

    if ([self.otherSwitch isOn]) {
        userObject[@"other"] = @"true";
    } else {
        userObject[@"other"] = @"false";
    }
    
    if ([self.anonymousSwitch isOn]) {
        userObject[@"anonymous"] = @"false";
    } else {
        userObject[@"anonymous"] = @"true";
    }
    
    [userObject saveInBackground];
}

- (void)stateChanged:(UISwitch *)switchState
{
    if ([switchState isOn]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Going Public"
                                                        message:@"Be aware by toggling this button you are choosing to publicily display your information."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
