//
//  ProfileViewController.h
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

    @property(weak, nonatomic) IBOutlet UIButton *submitButton;
    @property(nonatomic) NSDictionary *userProfile;

@end
