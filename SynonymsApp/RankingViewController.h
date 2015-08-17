//
//  RankingViewController.h
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/06/25.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *rankingTableView;

@end
