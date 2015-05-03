//
//  FeedTableViewController.h
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/3/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCollectionViewCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface FeedTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate >

    @property(nonatomic) UITableView *feedTableView;
@end
