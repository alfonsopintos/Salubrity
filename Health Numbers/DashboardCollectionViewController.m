//
//  DashboardCollectionViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "DashboardCollectionViewController.h"

@interface DashboardCollectionViewController ()
    @property (nonatomic) NSMutableArray *facebookIdArray;
@end

@implementation DashboardCollectionViewController

static NSString * const reuseIdentifier = @"dashboardCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self fetchUserFriends];
}

-(void) fetchUserFriends {
    [FBRequestConnection startWithGraphPath:@"/me/friends"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
//                              result is a hash of my friends who use the app
                              result = [result objectForKey:@"data"];

                              
                              self.facebookIdArray = [[NSMutableArray alloc] init];
                              
                              for (id friend in result) {
                                [self.facebookIdArray addObject:[friend objectForKey:@"id"]];
                              }
//                              returns array of friends user_ids
                              NSLog(@"%@", self.facebookIdArray);
                          }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (DashboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.cellNumberLabel.text = @"10";
    cell.cellTextLabel.text = @"HIV";
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked");
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
