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
    @property (nonatomic) NSMutableArray *parseIdArray;

    @property (nonatomic) NSMutableArray *hivArray;
    @property (nonatomic) NSMutableArray *herpesArray;
    @property (nonatomic) NSMutableArray *gonorrheaArray;
    @property (nonatomic) NSMutableArray *hpvArray;
    @property (nonatomic) NSMutableArray *chlamydiaArray;
    @property (nonatomic) NSMutableArray *otherArray;
@end

@implementation DashboardCollectionViewController

static NSString * const reuseIdentifier = @"dashboardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArrays];
    [self fetchUserFriends];
}


-(void) initArrays {
    self.hivArray = [[NSMutableArray alloc] init];
    self.herpesArray = [[NSMutableArray alloc] init];
    self.gonorrheaArray = [[NSMutableArray alloc] init];
    self.hpvArray = [[NSMutableArray alloc] init];
    self.chlamydiaArray = [[NSMutableArray alloc] init];
    self.otherArray = [[NSMutableArray alloc] init];
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
                              
                              NSArray *parseQuery = [[NSArray alloc] init];
                              parseQuery = self.facebookIdArray;
                              PFQuery *query = [PFQuery queryWithClassName:@"User"];
                              [query whereKey:@"facebook_id" containedIn:parseQuery];
                              
                              [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                  if (!error) {
                                      for (id friend in objects) {
//                                         hiv
                                          if ([[friend objectForKey:@"hiv"] isEqualToString:@"true"]) {
                                              [self.hivArray addObject:[friend objectForKey:@"hiv"]];
                                          }
//                                          herpes
                                          if ([[friend objectForKey:@"herpes"] isEqualToString:@"true"]) {
                                              [self.herpesArray addObject:[friend objectForKey:@"herpes"]];
                                          }
//                                          hpv
                                          if ([[friend objectForKey:@"hpv"] isEqualToString:@"true"]) {
                                              [self.hpvArray addObject:[friend objectForKey:@"hpv"]];
                                          }
//                                          chlamydia
                                          if ([[friend objectForKey:@"chlamydia"] isEqualToString:@"true"]) {
                                              [self.chlamydiaArray addObject:[friend objectForKey:@"chlamydia"]];
                                          }
//                                          gonorrhea
                                          if ([[friend objectForKey:@"gonorrhea"] isEqualToString:@"true"]) {
                                              [self.gonorrheaArray addObject:[friend objectForKey:@"gonorrhea"]];
                                          }
//                                          other
                                          if ([[friend objectForKey:@"other"] isEqualToString:@"true"]) {
                                              [self.otherArray addObject:[friend objectForKey:@"other"]];
                                          }
                                          
                                      }
                                  } else {
                                      NSLog(@"Error: %@ %@", error, [error userInfo]);
                                  }
                              }];
                            
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
