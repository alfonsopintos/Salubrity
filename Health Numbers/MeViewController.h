//
//  MeViewController.h
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/3/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface MeViewController : UIViewController <FBLoginViewDelegate>
    @property(weak, nonatomic) IBOutlet UIButton *submitButton;
    @property(nonatomic) NSDictionary *userProfile;
    @property (weak, nonatomic) IBOutlet UISwitch *hpvSwitch;
    @property (weak, nonatomic) IBOutlet UISwitch *chlamydiaSwitch;
    @property (weak, nonatomic) IBOutlet UISwitch *gonorrheaSwitch;
    @property (weak, nonatomic) IBOutlet UISwitch *hivSwitch;
    @property (weak, nonatomic) IBOutlet UISwitch *otherSwitch;
    @property (weak, nonatomic) IBOutlet UISwitch *anonymousSwitch;
@end
