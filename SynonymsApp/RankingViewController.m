//
//  RankingViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/06/25.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "RankingViewController.h"
#import "AppDelegate.h"

@interface RankingViewController () {
    AppDelegate *_ap;
    UIButton *_backBtn;
}

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.rankingTableView.delegate = self;
    self.rankingTableView.dataSource = self;
    
    CGSize size = self.view.frame.size;
    _backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backBtn.frame = CGRectMake(size.width * 2 / 3 , size.height * 1 / 8, size.width / 5, size.height * 1 / 9);
    [_backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [_backBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    [_backBtn addTarget:self action:@selector(pushBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _backBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _backBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:_backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushBackBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld: score",indexPath.row + 1];
    [cell.textLabel setFont:[UIFont systemFontOfSize:26]];
    cell.detailTextLabel.text = @"From core data";
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:26]];
    return cell;
}


@end
