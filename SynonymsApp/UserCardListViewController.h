//
//  UserCardListViewController.h
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/26.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCardListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *userCardTableView;


@end
