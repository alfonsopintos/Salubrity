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

    @property (nonatomic) NSMutableArray *stringCountArray;
@end

@implementation DashboardCollectionViewController

static NSString * const reuseIdentifier = @"dashboardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArrays];
    [self fetchUserFriends];
    [self.dashboardCollectionView reloadData];
}

-(void) viewDidAppear:(BOOL)animated {
    [self makeCountArray];
    [self.dashboardCollectionView reloadData];
}

-(void) initArrays {
    self.hivArray = [[NSMutableArray alloc] init];
    self.herpesArray = [[NSMutableArray alloc] init];
    self.gonorrheaArray = [[NSMutableArray alloc] init];
    self.hpvArray = [[NSMutableArray alloc] init];
    self.chlamydiaArray = [[NSMutableArray alloc] init];
    self.otherArray = [[NSMutableArray alloc] init];
}

-(void) makeCountArray {
    self.stringCountArray = [[NSMutableArray alloc] init];
    [self.stringCountArray addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[self.hivArray count]]];
    [self.stringCountArray addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[self.herpesArray count]]];
    [self.stringCountArray addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[self.chlamydiaArray count]]];
    [self.stringCountArray addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[self.gonorrheaArray count]]];
    [self.stringCountArray addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[self.hpvArray count]]];
    [self.stringCountArray addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[self.otherArray count]]];
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
                                      
//                                    [self postCounterToParse];
                                  } else {
                                      NSLog(@"Error: %@ %@", error, [error userInfo]);
                                  }
                              }];
                          }];
    [self.dashboardCollectionView reloadData];
}



//-(void) postCounterToParse {
//    PFObject *counterObject = [PFObject objectWithClassName:@"Counter"];
//    
//    counterObject[@"hiv_count"] = [NSString stringWithFormat:@"%lu", (unsigned long)[self.hivArray count]];
//    counterObject[@"hpv_count"] = [NSString stringWithFormat:@"%lu", (unsigned long)[self.hpvArray count]];
//    counterObject[@"herpes_count"] = [NSString stringWithFormat:@"%lu", (unsigned long)[self.herpesArray count]];
//    counterObject[@"chlamydia_count"] = [NSString stringWithFormat:@"%lu", (unsigned long)[self.chlamydiaArray count]];
//    counterObject[@"gonorrhea_count"] = [NSString stringWithFormat:@"%lu", (unsigned long)[self.gonorrheaArray count]];
//    counterObject[@"other_count"] = [NSString stringWithFormat:@"%lu", (unsigned long)[self.otherArray count]];
//    
//    [counterObject saveInBackground];
//}





#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (DashboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *cellTitles = [[NSMutableArray alloc] initWithObjects:@"HIV", @"Herpes", @"Chlamydia", @"Gonorrhea", @"HPV", @"Other", nil];
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.cellNumberLabel.text = [self.stringCountArray objectAtIndex:indexPath.row];
    cell.cellTextLabel.text = [cellTitles objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    
//    red - [UIColor colorWithRed:0.82 green:0.243 blue:0.149 alpha:1]];
//    green - [UIColor colorWithRed:0.643 green:0.804 blue:0.224 alpha:1]
//    blue - [UIColor colorWithRed:0.294 green:0.773 blue:0.929 alpha:1]


    
    if (cell.tag == 0) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.82 green:0.243 blue:0.149 alpha:1]];
    } else if (cell.tag == 1) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.643 green:0.804 blue:0.224 alpha:1]];
    } else if (cell.tag == 2) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.294 green:0.773 blue:0.929 alpha:1]];
    } else if (cell.tag == 3) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.82 green:0.243 blue:0.149 alpha:1]];
    } else if (cell.tag == 4) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.643 green:0.804 blue:0.224 alpha:1]];
    } else if (cell.tag == 5) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.294 green:0.773 blue:0.929 alpha:1]];
    }
    
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
