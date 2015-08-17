//
//  CardListViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "CardListViewController.h"
#import "AppDelegate.h"
@interface CardListViewController (){
    
    UILabel *myLabel;
//    NSUserDefaults *myDefaults;
    NSUserDefaults *initDefaults;
    AppDelegate *ap;
    
    UIButton *backBtn;
}

@end

@implementation CardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size = self.view.frame.size;
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width / 18, size.height / 18, size.width / 6, size.height /25)];
    backBtn.backgroundColor = [UIColor grayColor];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    backBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    backBtn.titleLabel.minimumScaleFactor = 8;
    backBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [backBtn addTarget:self action:@selector(pushBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self.view addSubview:backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ap.allWordsAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseidentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseidentifier];
        
//        myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
//        myLabel.tag = 100;
//        [cell.contentView addSubview:myLabel];
    }
    
    myLabel = (UILabel *)[cell viewWithTag:100];
    
    cell.textLabel.text = ap.allWordsAry[indexPath.row];
    
    NSLog(@"%li of myDefaults = %d",(long)indexPath.row,[ap.myDefaults boolForKey:ap.allWordsAry[indexPath.row]]);
    if ([ap.myDefaults boolForKey:ap.allWordsAry[indexPath.row]]) {
        myLabel.text = @"";
    } else {
        myLabel.text = @"eliminated";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath");
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    myLabel = (UILabel *)[cell viewWithTag:100];
    if ([ap.myDefaults boolForKey:ap.allWordsAry[indexPath.row]]) {
        [ap.myDefaults setBool:NO forKey:ap.allWordsAry[indexPath.row]];
        [ap.myDefaults setBool:NO forKey:[ap.allWordsDic objectForKey:ap.allWordsAry[indexPath.row]]];
//        [self searchAry:ap.allWordsAry indexNum:indexPath.row];
//        NSLog(@"index = %li",(long)index);
        myLabel.text = @"eliminated";
    }else if (![ap.myDefaults boolForKey:ap.allWordsAry[indexPath.row]]){
        [ap.myDefaults setBool:YES forKey:ap.allWordsAry[indexPath.row]];
        [ap.myDefaults setBool:YES forKey:[ap.allWordsDic objectForKey:ap.allWordsAry[indexPath.row]]];
        
        myLabel.text = @"";
    }
    NSLog(@"%li of didSelect %@", (long)indexPath.row, [ap.myDefaults objectForKey:ap.allWordsAry[indexPath.row]]);
    [tableView reloadData];
}

- (IBAction)pushBack:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)searchAry:(NSArray *)ary indexNum:(NSInteger) aryIndex{
    NSInteger index = 0;
    for (int i = 0; i <= ary.count; i++) {
        if ([ary[i] isEqualToString:[ap.allWordsDic objectForKey:ap.allWordsAry[aryIndex]]]) {
            index = i;
            break;
        }
    }
    return index;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
