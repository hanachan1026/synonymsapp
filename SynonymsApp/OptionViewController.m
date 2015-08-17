//
//  OptionViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "OptionViewController.h"
#import "MainViewController.h"
#import "CardListViewController.h"
#import "UserCardListViewController.h"
#import "RankingViewController.h"

@interface OptionViewController () {
    UIButton *cardListBtn;
    UIButton *userCardListBtn;
    UIButton *_rankingBtn;
    UIButton *homeBtn;
}

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size = self.view.frame.size;
    cardListBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cardListBtn setTitle:@"Card List" forState:UIControlStateNormal];
    [cardListBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:35]];
    [cardListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cardListBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    cardListBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    cardListBtn.titleLabel.minimumScaleFactor = 8;
    cardListBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    cardListBtn.frame = CGRectMake(size.width / 4, size.height * 3 / 10, size.width / 2, size.height / 9);
    cardListBtn.backgroundColor = [UIColor blueColor];
    [cardListBtn addTarget:self action:@selector(pushCardList:) forControlEvents:UIControlEventTouchUpInside];
    
    userCardListBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [userCardListBtn setTitle:@"UserCard List" forState:UIControlStateNormal];
    [userCardListBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:35]];
    [userCardListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    userCardListBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    userCardListBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    userCardListBtn.titleLabel.minimumScaleFactor = 8;
    userCardListBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    userCardListBtn.frame = CGRectMake(size.width / 8, size.height * 9 / 20, size.width *3 / 4 , size.height / 9);
    userCardListBtn.backgroundColor = [UIColor blueColor];
    [userCardListBtn addTarget:self action:@selector(pushUserCardList:) forControlEvents:UIControlEventTouchUpInside];
    
    _rankingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _rankingBtn.frame = CGRectMake(size.width / 4, size.height * 3 / 5, size.width / 2, size.height / 9);
    [_rankingBtn setTitle:@"Ranking" forState:UIControlStateNormal];
    [_rankingBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    [_rankingBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    _rankingBtn.backgroundColor = [UIColor greenColor];
    [_rankingBtn addTarget:self action:@selector(pushRankingBtn:) forControlEvents:UIControlEventTouchUpInside];
    _rankingBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _rankingBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _rankingBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    homeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [homeBtn setTitle:@"Home" forState:UIControlStateNormal];
    [homeBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    homeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    homeBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    homeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    homeBtn.titleLabel.minimumScaleFactor = 8;
    homeBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    homeBtn.frame = CGRectMake(size.width * 7 / 10, size.height * 3 / 4, size.width *1 / 4 , size.height / 20);
    [homeBtn addTarget:self action:@selector(pushHome:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    [self.view addSubview:cardListBtn];
    [self.view addSubview:userCardListBtn];
    [self.view addSubview:_rankingBtn];
    [self.view addSubview:homeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)pushHome:(id)sender {
    MainViewController *MVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MVC"];
    [self presentViewController:MVC animated:YES completion:nil];
}

- (IBAction)pushCardList:(id)sender {
    CardListViewController *CLVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CLVC"];
    [self presentViewController:CLVC animated:YES completion:nil];

}

- (IBAction)pushUserCardList:(id)sender {
    UserCardListViewController *UCLVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UCLVC"];
    [self presentViewController:UCLVC animated:YES completion:nil];
}

- (IBAction)pushRankingBtn:(id)sender {
    RankingViewController *RKVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RKVC"];
    [self presentViewController:RKVC animated:YES completion:nil];
}


@end
