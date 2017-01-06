//
//  MISRateDetailViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/19.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISRateDetailViewController.h"
#import "Review.h"
#import "NeetMSTranslator/NMSTranslator.h"
#import "MISReviewCell.h"

@interface MISRateDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *reviewText;

@end

@implementation MISRateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return _reviews.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MISReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MISReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Review *review = _reviews[indexPath.section];
    cell.review_text.text = review.text;
    cell.review_auther.text = review.authorName;
    cell.review_rating.value = review.rating;
    cell.review_rating.allowsHalfStars = YES;
    cell.review_rating.userInteractionEnabled = NO;
    
    return cell;
}

@end
