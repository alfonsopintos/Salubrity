//
//  DashboardCollectionViewController.h
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCollectionViewCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ProfileViewController.h"

@interface DashboardCollectionViewController : UICollectionViewController
    @property (strong, nonatomic) IBOutlet UICollectionView *dashboardCollectionView;
@end
