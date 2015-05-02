//
//  DashboardCollectionViewCell.h
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardCollectionViewCell : UICollectionViewCell
    @property(weak, nonatomic) IBOutlet UILabel *cellNumberLabel;
    @property(weak, nonatomic) IBOutlet UILabel *cellTextLabel;
@end
