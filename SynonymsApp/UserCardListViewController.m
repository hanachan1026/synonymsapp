//
//  UserCardListViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/26.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "UserCardListViewController.h"
#import "AppDelegate.h"
#import "UserWords.h"
#import "RegisterViewController.h"
@interface UserCardListViewController (){
    AppDelegate *ap;
//    UILabel *leftLabel;
//    UILabel *rightLabel;
    UIAlertView *alert;
    NSString *predicateStr;
    
    UIButton *backBtn;
    UIButton *addBtn;
    UILabel *middleLabel;
}
@property (strong, nonatomic) NSMutableArray *userWordsAry;
@property (strong, nonatomic) NSMutableArray *userKeyWordsAry;
@property (strong, nonatomic) NSMutableArray *userValueWordsAry;
@end

@implementation UserCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size = self.view.frame.size;
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width / 12, size.height / 16, size.width / 6, size.height /25)];
    backBtn.backgroundColor = [UIColor grayColor];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    backBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    backBtn.titleLabel.minimumScaleFactor = 8;
    backBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [backBtn addTarget:self action:@selector(pushBack:) forControlEvents:UIControlEventTouchUpInside];
    
    addBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width * 11 / 12 - backBtn.frame.size.width, size.height / 16, size.width / 6, size.height /25)];
    addBtn.backgroundColor = [UIColor blueColor];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    addBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    addBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    addBtn.titleLabel.minimumScaleFactor = 8;
    addBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [addBtn addTarget:self action:@selector(pushAdd:) forControlEvents:UIControlEventTouchUpInside];


    
    alert = [[UIAlertView alloc] init];
    alert.title = @"Delete";
    alert.message = @"Are you sure you want to delete?";
    alert.delegate = self;
    [alert addButtonWithTitle:@"cancel"];
    [alert addButtonWithTitle:@"OK"];
    
    ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.userCardTableView.delegate = self;
    self.userCardTableView.dataSource = self;
    
    [self makeKeyAndValueAry];
    middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width / 3, size.height / 16, size.width / 3, size.height / 25)];
    middleLabel.text = [NSString stringWithFormat:@"%ld/25 pairs",self.userKeyWordsAry.count];
    [middleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    middleLabel.textAlignment = NSTextAlignmentCenter;
    middleLabel.adjustsFontSizeToFitWidth = YES;
    middleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    middleLabel.minimumScaleFactor = 8;
    middleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    if (self.userKeyWordsAry.count == 25) {
        middleLabel.textColor = [UIColor redColor];
        addBtn.enabled = NO;
    }
    [ap.userWordsAryCountDefaults setInteger:self.userKeyWordsAry.count forKey:@"userWordsAryCount"];
    
    [self.view addSubview:backBtn];
    [self.view addSubview:addBtn];
    [self.view addSubview:middleLabel];
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

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userKeyWordsAry count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView reloadData];
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        
    }



    cell.textLabel.text =  _userKeyWordsAry[indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:26]];
//    rightLabel.text = _userValueWordsAry[indexPath.row];
//    NSLog(@"userKeyWordsAry = %@",_userKeyWordsAry[indexPath.row]);
//    NSLog(@"userValueWordsAry = %@",_userValueWordsAry[indexPath.row]);
//    NSLog(@"leftLabel.text = %@",leftLabel.text);
//    NSLog(@"rightLabel.text = %@",rightLabel.text);

//    NSLog(@"result1 = %@\nresult2 = %@",_result1,_result2);
//    CGPoint offset = tableView.contentOffset;
//    CGRect rect = cell.frame;
////    rect.origin.y = rect.origin.y - offset.y;
//    CGSize cellSize = cell.contentView.frame.size;
//    CGSize size = self.view.bounds.size;
//    UILabel *rightLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 3 / 5, rect.origin.y, size.width / 3, cellSize.height / 2 + 10)];
//    rightLabel2.text = _userValueWordsAry[indexPath.row];
//    rightLabel2.textAlignment = NSTextAlignmentCenter;
//    [rightLabel2 setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:26]];
//    [cell addSubview:rightLabel2];

    cell.detailTextLabel.text = _userValueWordsAry[indexPath.row];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:26]];
    
    return cell;
}

- (IBAction)pushAdd:(id)sender {
    RegisterViewController *registerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RVC"];
    [self presentViewController:registerViewController animated:YES completion:nil];
}

- (IBAction)pushBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    NSLog(@"viewWillAppear");
//    [self.userCardTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    predicateStr = [NSString stringWithFormat:@"keyWord == \"%@\"",[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text];
    NSLog(@"textLabel.text = %@",[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text);
    //    NSLog(@"BeforeFetch keyWord = %@\nvalueWord = %@",userWords.keyWord,userWords.valueWord);
    [alert show];
    
//    NSString *predicateStr1 = [NSString stringWithFormat:@"keyWord == \"%@\"",[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text];
//    NSLog(@"textLabel.text = %@",[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text);
////    NSLog(@"BeforeFetch keyWord = %@\nvalueWord = %@",userWords.keyWord,userWords.valueWord);
//    [self myfetch:predicateStr1];
  
//      [self myfetch:predicateStr2];
  
//    NSLog(@"userKeyWordsAry = %@",_userKeyWordsAry[indexPath.row]);
//    NSLog(@"userValueWordsAry = %@",_userValueWordsAry[indexPath.row]);
//    [self.userCardTableView beginUpdates];
    
//    int path;
//    NSIndexPath *indexPath2;
//    if ([_userKeyWordsAry containsObject:[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text]) {
//        path = indexPath.row + _userKeyWordsAry.count;
//        indexPath2 = [NSIndexPath indexPathForRow:path - 1 inSection:0];
//        [self myfetch:@"(keyWord = %@)" didSelectRowAtIndexPath:indexPath];
//        [self myfetch:@"(valueWord = %@)" didSelectRowAtIndexPath:indexPath2];
//    }else{
//        path = indexPath.row - _userValueWordsAry.count;
//        indexPath2 = [NSIndexPath indexPathForRow:path - 1 inSection:0];
//        [self myfetch:@"(valueWord = %@)" didSelectRowAtIndexPath:indexPath];
//        [self myfetch:@"(keyWord = %@)" didSelectRowAtIndexPath:indexPath2];
//    }
//    NSLog(@"keyWord = %@\nvalueWord = %@",userWords.keyWord,userWords.valueWord);
    
    // 先にデータソースを削除する
//    AppDelegate *manager = [AppDelegate sharedManager];
//    UserWords *userWords = (UserWords *)[manager entityForInsert:@"UserWords"];
//    NSManagedObject *objectToDelete;
////    NSManagedObject *objectToDelete2;
//    [objectToDelete delete:[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text];
//    NSLog(@"textlabel.text = %@",[self.userCardTableView cellForRowAtIndexPath:indexPath].textLabel.text);
//    [manager.managedObjectContext deleteObject:objectToDelete];
//    [manager saveContext];
//    NSError *error;
//    if (![manager.managedObjectContext save:&error])
//    {
//        NSLog(@"couldn't save");
//    }
    
//    NSLog(@"key = %@",userWords.keyWord);
//    NSLog(@"value = %@",userWords.valueWord);
//    if (indexPath.row % 2 == 0) {
//        [_userKeyWordsAry removeObjectAtIndex:indexPath.row];
//        [_userValueWordsAry removeObjectAtIndex:indexPath.row];
//    }else {
//        [_userKeyWordsAry removeObjectAtIndex:indexPath.row / 2];
//        [_userValueWordsAry removeObjectAtIndex:indexPath.row / 2];
//    }
    
//    NSLog(@"userKeyWordsAry = %@",_userKeyWordsAry[indexPath.row]);
//    NSLog(@"userValueWordsAry = %@",_userValueWordsAry[indexPath.row]);
    
//    NSArray *deleteAry = @[indexPath,indexPath2];
//    // UITableView の行を削除する
//    [tableView deleteRowsAtIndexPaths:deleteAry withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.userCardTableView endUpdates];

}

- (NSInteger)searchAry:(NSArray *)ary tappedCell:(NSString *) str{
    NSInteger index = 0;
    for (int k = 0; k <= ary.count; k++) {
        if ([ary[k] isEqualToString:str]) {
            index = k;
            break;
        }
    }
    return index;
}

- (void)myfetch:(NSString *)str {
    NSManagedObjectContext *context = [[AppDelegate new] managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserWords"
                                                         inManagedObjectContext:context];
    [fetchRequest setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSError *error2;
    NSArray *objects = [context executeFetchRequest:fetchRequest
                                              error:&error2];
    NSLog(@"objects : %@",objects);
    
    for(NSManagedObject * object in objects)
    {
        [context deleteObject:object];
    }
    [ap.numDefaults setInteger:ap.numberOfData - 1 forKey:@"dataInt"];
    ap.numberOfData--;
    [ap.numDefaults synchronize];
    NSLog(@"ap.numDefaults after fetch = %i",[ap.numDefaults integerForKey:@"dataInt"]);
    NSLog(@"ap.numberOfData after fetch = %d",ap.numberOfData);

    if(![context save:&error])
    {
        NSLog(@"データの削除失敗");
    }else
    {
        NSLog(@"データの削除成功");
    }
}

-(void)makeKeyAndValueAry {
    AppDelegate *manager = [AppDelegate sharedManager];
    _userWordsAry = [manager all:@"UserWords" sortKey:@"userWordsId"];
    _userKeyWordsAry = [[NSMutableArray alloc] init];
    _userValueWordsAry = [[NSMutableArray alloc] init];
    
    int j = 0;
    for (NSManagedObject *a in _userWordsAry) {
        UserWords *UW = (UserWords *)a;
        if (UW.keyWord == nil) {
            break;
        }
        _userKeyWordsAry[j] = UW.keyWord;
        j++;
    }
    j = 0;
    for (NSManagedObject *a in _userWordsAry) {
        UserWords *UW = (UserWords *)a;
        if (UW.valueWord == nil) {
            break;
        }
        _userValueWordsAry[j] = UW.valueWord;
        j++;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"canceled");
            break;
        case 1:
            NSLog(@"deleted");
            [self myfetch:predicateStr];
            [self makeKeyAndValueAry];
            [self.userCardTableView reloadData];
            middleLabel.text = [NSString stringWithFormat:@"%ld/25 pairs",self.userKeyWordsAry.count];
            middleLabel.textColor = [UIColor blackColor];
            if (!addBtn.isEnabled) {
                addBtn.enabled = YES;
            }
            [ap.userWordsAryCountDefaults setInteger:self.userKeyWordsAry.count forKey:@"userWordsAryCount"];
            break;
        default:
            break;
    }
}

@end
