//
//  GameViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "GameViewController.h"
#import "CardListViewController.h"
#import "AppDelegate.h"
#import "UserWords.h"

#define MARGIN 5

@interface GameViewController ()<UIAlertViewDelegate> {
    NSUserDefaults *myDefaults;
    AppDelegate *ap;
    // tap count number b
    int b;
    // タップされたボタンタイトル保持配列
    NSString *tappedBtnStr1;
    NSString *tappedBtnStr2;
    
    NSArray *btnAry;
    //　どのボタンが押されたか情報保持配列
    NSMutableArray *pushedBtnAry;
    
    // randNum の残り保持配列
    NSMutableArray *tempAry;
    
    //　マッチした回数カウント
    int correctCount;
    
    int levelWordsAryCount;
    
    NSTimer *timer; //クイズ中の経過時間を生成する
    int countDown;  //設定時間
    
    NSMutableArray *gameWordsAry;
    NSMutableArray *userWordsAry;
    NSMutableArray *userKeyWordsAry;
    NSMutableArray *userValueWordsAry;
    NSInteger index1;
    NSInteger index2;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    UIButton *btn7;
    UIButton *btn8;
    UIButton *btn9;
    UIButton *btn10;
    UIButton *homeBtn;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // btn 作る
    CGSize size = self.view.frame.size;
    // btn1
    btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(MARGIN, size.height / 9, size.width / 2 - MARGIN, size.height / 7);
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 addTarget:self action:@selector(btn1Tap:) forControlEvents:UIControlEventTouchUpInside];
    
    // 縦の位置ずらしのための変数
    float moveHeight = btn1.frame.size.height + MARGIN;
    
    // btn2
    btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(size.width / 2 + MARGIN, size.height / 9, size.width / 2 - MARGIN * 2, size.height / 7);
//    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(btn2Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn3
    btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(MARGIN, size.height / 9 + moveHeight, size.width / 2 - MARGIN, size.height / 7);
    btn3.backgroundColor = [UIColor grayColor];
    [btn3 addTarget:self action:@selector(btn3Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn4
    btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn4.frame = CGRectMake(size.width / 2 + MARGIN, size.height / 9 + moveHeight, size.width / 2 - MARGIN * 2, size.height / 7);
//    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor greenColor];
    [btn4 addTarget:self action:@selector(btn4Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn5
    btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn5.frame = CGRectMake(MARGIN, size.height / 9 + moveHeight * 2, size.width / 2 - MARGIN, size.height / 7);
    btn5.backgroundColor = [UIColor grayColor];
    [btn5 addTarget:self action:@selector(btn5Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn6
    btn6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn6.frame = CGRectMake(size.width / 2 + MARGIN, size.height / 9 + moveHeight * 2, size.width / 2 - MARGIN * 2, size.height / 7);
//    [btn6 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn6.backgroundColor = [UIColor greenColor];
    [btn6 addTarget:self action:@selector(btn6Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn7
    btn7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn7.frame = CGRectMake(MARGIN, size.height / 9 + moveHeight * 3, size.width / 2 - MARGIN, size.height / 7);
    btn7.backgroundColor = [UIColor grayColor];
    [btn7 addTarget:self action:@selector(btn7Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn8
    btn8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn8.frame = CGRectMake(size.width / 2 + MARGIN, size.height / 9 + moveHeight * 3, size.width / 2 - MARGIN * 2, size.height / 7);
//    [btn8 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn8.backgroundColor = [UIColor greenColor];
    [btn8 addTarget:self action:@selector(btn8Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn9
    btn9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn9.frame = CGRectMake(MARGIN, size.height / 9 + moveHeight * 4, size.width / 2 - MARGIN, size.height / 7);
    btn9.backgroundColor = [UIColor grayColor];
    [btn9 addTarget:self action:@selector(btn9Tap:) forControlEvents:UIControlEventTouchUpInside];
    // btn10
    btn10 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn10.frame = CGRectMake(size.width / 2 + MARGIN, size.height / 9 + moveHeight * 4, size.width / 2 - MARGIN * 2, size.height / 7);
//    [btn10 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn10.backgroundColor = [UIColor greenColor];
    [btn10 addTarget:self action:@selector(btn10Tap:) forControlEvents:UIControlEventTouchUpInside];
    
    homeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    homeBtn.frame = CGRectMake(MARGIN, size.height / 9 + moveHeight * 5 + MARGIN * 2, size.width / 4, size.height / 20);
    [homeBtn setTitle:@"Home" forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(pushHome:) forControlEvents:UIControlEventTouchUpInside];
    
    
    gameWordsAry = [[NSMutableArray alloc] init];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"correctBuzzer" ofType:@"mp3"];
    NSURL *url1 = [NSURL fileURLWithPath:path1];
    self.correctSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:NULL];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"wrongBuzzer" ofType:@"mp3"];
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    self.wrongSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:NULL];

    b = 0;
    
    tempAry = [NSMutableArray array];
    
    ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    myDefaults = [NSUserDefaults standardUserDefaults];
//    CardListViewController *CLVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CLVC"];
    
    // wordsAryにYESのBool値が入っているwordsを入れる
    
//    int j = 0;
//    for (int i = 0; i < ap.allWordsAry.count; i++) {
//        if ([ap.myDefaults boolForKey:ap.allWordsAry[i]]) {
//            
//            ap.wordsAry[j]= ap.allWordsAry[i];
////            NSLog(@"\n i = %d \n allWordsAry = %@",i,ap.allWordsAry[i]);
////            NSLog(@"\n j = %d \n wordsAry = %@",j,ap.wordsAry[j]);
//            j++;
//        }
//    }
    
    
    for (int i = 0; i < ap.allWordsAry.count; i++) {
//        NSLog(@"myDefaults key = %d", [myDefaults boolForKey:ap.allWordsAry[i]]);
    }

  
    if ([ap.levelStr isEqualToString:@"Easy"]) {
        [self getWords:(NSMutableArray *)ap.easyWordsAry];
        countDown = 30.0; //　設定時間「30秒」
    }else if([ap.levelStr isEqualToString:@"Normal"]){
        [self getWords:(NSMutableArray *)ap.normalWordsAry];
        countDown = 25.0; //　設定時間「25秒」
    }else if ([ap.levelStr isEqualToString:@"Hard"]){
        [self getWords:(NSMutableArray *)ap.hardWordsAry];
        countDown = 20.0; //　設定時間「20秒」
    }else if ([ap.levelStr isEqualToString:@"User"]){
        AppDelegate *manager = [AppDelegate sharedManager];
        userWordsAry = [manager all:@"UserWords" sortKey:@"userWordsId"];
        userKeyWordsAry = [[NSMutableArray alloc] init];
        userValueWordsAry = [[NSMutableArray alloc] init];
        
        int j = 0;
        for (NSManagedObject *a in userWordsAry) {
            UserWords *UW = (UserWords *)a;
            userKeyWordsAry[j] = UW.keyWord;
            j++;
        }
        j = 0;
        for (NSManagedObject *a in userWordsAry) {
            UserWords *UW = (UserWords *)a;
                userValueWordsAry[j] = UW.valueWord;
                j++;
        }
//        NSLog(@"userKeyWordsAry = %@",userKeyWordsAry);
//        NSLog(@"userValueWordsAry = %@",userValueWordsAry);
        NSMutableArray *userKeyWordsAry1 = [[NSMutableArray alloc] init];
        NSMutableArray *userKeyWordsAry2 = [[NSMutableArray alloc] init];
        NSMutableArray *userKeyWordsAry3 = [[NSMutableArray alloc] init];
        NSMutableArray *userKeyWordsAry4 = [[NSMutableArray alloc] init];
        NSMutableArray *userKeyWordsAry5 = [[NSMutableArray alloc] init];
        NSMutableArray *userValueWordsAry1 = [[NSMutableArray alloc] init];
        NSMutableArray *userValueWordsAry2 = [[NSMutableArray alloc] init];
        NSMutableArray *userValueWordsAry3 = [[NSMutableArray alloc] init];
        NSMutableArray *userValueWordsAry4 = [[NSMutableArray alloc] init];
        NSMutableArray *userValueWordsAry5 = [[NSMutableArray alloc] init];
        NSMutableArray *userWordsAry1 = [[NSMutableArray alloc] init];
        NSMutableArray *userWordsAry2 = [[NSMutableArray alloc] init];
        NSMutableArray *userWordsAry3 = [[NSMutableArray alloc] init];
        NSMutableArray *userWordsAry4 = [[NSMutableArray alloc] init];
        NSMutableArray *userWordsAry5 = [[NSMutableArray alloc] init];
        int userWordsAryCount = userKeyWordsAry.count + userValueWordsAry.count;
        NSLog(@"userWordsAryCount = %d",userWordsAryCount);
        if (userWordsAryCount >= 10) {
            for (int i = 0; i < 5; i++) {
                userKeyWordsAry1[i] = userKeyWordsAry[i];
                userValueWordsAry1[i] = userValueWordsAry[i];
                userWordsAry1 = [userKeyWordsAry1 arrayByAddingObjectsFromArray:userValueWordsAry1];
            }
        }
        if (userWordsAryCount >= 20) {
            for (int i = 0; i < 5; i++) {
                userKeyWordsAry2[i] = userKeyWordsAry[i + 5];
                userValueWordsAry2[i] = userValueWordsAry[i + 5];
                userWordsAry2 = [userKeyWordsAry2 arrayByAddingObjectsFromArray:userValueWordsAry2];
            }
        }
        if (userWordsAryCount >= 30) {
            for (int i = 0; i < 5; i++) {
                userKeyWordsAry3[i] = userKeyWordsAry[i + 10];
                userValueWordsAry3[i] = userValueWordsAry[i + 10];
                userWordsAry3 = [userKeyWordsAry3 arrayByAddingObjectsFromArray:userValueWordsAry3];
            }
        }
        if (userWordsAryCount >= 40) {
            for (int i = 0; i < 5; i++) {
                userKeyWordsAry4[i] = userKeyWordsAry[i + 15];
                userValueWordsAry4[i] = userValueWordsAry[i + 15];
                userWordsAry4 = [userKeyWordsAry4 arrayByAddingObjectsFromArray:userValueWordsAry4];
            }
        }
        if (userWordsAryCount == 50) {
            for (int i = 0; i < 5; i++) {
                userKeyWordsAry5[i] = userKeyWordsAry[i + 20];
                userValueWordsAry5[i] = userValueWordsAry[i + 20];
                userWordsAry5 = [userKeyWordsAry5 arrayByAddingObjectsFromArray:userValueWordsAry5];
            }
        }
//        NSLog(@"userWordsAry = %@",userWordsAry);
        int randNum;
        if (userWordsAryCount >= 10) {
            randNum = 0;
        }
        if (userWordsAryCount >= 20) {
            randNum = rand() % 2;
        }
        if (userWordsAryCount >= 30) {
            randNum = rand() % 3;
        }
        if (userWordsAryCount >= 40) {
            randNum = rand() % 4;
        }
        if (userWordsAryCount == 50) {
            randNum = rand() % 5;
        }
        
        switch (randNum) {
            case 0:
                gameWordsAry = userWordsAry1;
                break;
            case 1:
                gameWordsAry = userWordsAry2;
                break;
            case 2:
                gameWordsAry = userWordsAry3;
                break;
            case 3:
                gameWordsAry = userWordsAry4;
                break;
            case 4:
                gameWordsAry = userWordsAry5;
                break;
            default:
                break;
        }
        
        NSLog(@"gameWordsAry = %@",gameWordsAry);
        
        countDown = 25.0;
    }
    [self getRandWords];
    
    btnAry = @[btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10];
    
    pushedBtnAry = [NSMutableArray array];
    
    correctCount = 0;
    
    timer = [NSTimer
             scheduledTimerWithTimeInterval:1
             target: self
             selector:@selector(TimerAction)
             userInfo:nil
             repeats:YES];
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d",countDown];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
    [self.view addSubview:btn6];
    [self.view addSubview:btn7];
    [self.view addSubview:btn8];
    [self.view addSubview:btn9];
    [self.view addSubview:btn10];
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
    [timer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)pushDone:(id)sender {
//    [self gameFinish];
//    
//}

- (IBAction)btn1Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn2Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn3Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn4Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn5Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn6Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn7Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn8Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn9Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (IBAction)btn10Tap:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    [self selectWord:sender_btn];
}

- (void)selectWord:(UIButton *)button {
    b++;
    
    if (b % 2 == 1) {
        // 押したボタンを取得する
//        NSLog(@"button title = %@",button.titleLabel.text);
        // 押したボタンを配列に入れる
        [pushedBtnAry insertObject:button atIndex:0];
        // 選択状態にする
        button.selected = YES;
        // 押せなくする
        button.enabled = NO;
        // ボタンタイトルを別の配列に保持する
        tappedBtnStr1 = button.titleLabel.text;
//        NSLog(@"tappedBtnStr1 = %@",tappedBtnStr1);
        
    }else{
        // 押したボタンを配列に入れる
        [pushedBtnAry insertObject:button atIndex:1];
        
        // ボタンタイトルを比較
        tappedBtnStr2 = button.titleLabel.text;
//        NSLog(@"tappedBtnStr2 = %@",tappedBtnStr2);
        
//      正解          ボタン消す、不正解の時解除する
//        if ([[ap.plistDic objectForKey:tappedBtnStr1] isEqualToString:tappedBtnStr2]) {
//            NSLog(@"correct");
//            // 正解音
//            [self.correctSound play];
//            // 正解のボタン消す,新しいボタン出す
//            for (int j = 0; j < 2; j++) {
//                UIButton *pushedBtn = pushedBtnAry[j];
//                pushedBtn.hidden = YES;
//                if (j + 2 * correctCount < tempAry.count) {
//                    NSLog(@"tempAry = %@",tempAry[j + 2 * correctCount]);
//                    [pushedBtn setTitle:tempAry[j + 2 * correctCount] forState:UIControlStateNormal];
//                    pushedBtn.hidden = NO;
//                    pushedBtn.enabled = YES;
//                    pushedBtn.selected = NO;
//                }
//            }
//            correctCount++;
//            [pushedBtnAry removeAllObjects];
////      不正解
//        }else{
//            // 不正解音
//            [self.wrongSound play];
//            //解除
//            for (int i = 0; i <= 9; i++) {
//                UIButton *btn = btnAry[i];
//                btn.enabled = YES;
//                btn.selected = NO;
//            }
//            NSLog(@"not correct");
//        }
        if ([ap.levelStr isEqualToString:@"Easy"]) {
            [self judgeWords:ap.easyWordsDic];
        }else if ([ap.levelStr isEqualToString:@"Normal"]){
            [self judgeWords:ap.normalWordsDic];
        }else if ([ap.levelStr isEqualToString:@"Hard"]){
            [self judgeWords:ap.hardWordsDic];
        }else if ([ap.levelStr isEqualToString:@"User"]){
            [self judgeUserWords];
        }
    }
    // クリア時
    if (correctCount == levelWordsAryCount / 2) {
        // timer stop
//        [timer invalidate];
//        [self GamecenterInit];
//        [self submitScore:755 forCategory:@"iTunesConnectで付けたID"];
//
//        // 終わった時のラベル出す
//        UILabel *finishedLabel = [[UILabel alloc] init];
//        finishedLabel.frame = CGRectMake(self.view.frame.size.width / 4, self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 8);
//        finishedLabel.text = @"finished!";
//        finishedLabel.font = [UIFont fontWithName:@"AppleGothic" size:40];
//        finishedLabel.textAlignment = UITextAlignmentCenter;
//        finishedLabel.backgroundColor = [UIColor redColor];
//        [self.view addSubview:finishedLabel];
//        
//        // point
//        int point = countDown;
//        NSLog(@"point = %d",point);
//        UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, self.view.frame.size.height / 4 + finishedLabel.frame.size.height, finishedLabel.frame.size.width, finishedLabel.frame.size.height)];
//        if (point > 1) {
//        pointLabel.text = [NSString stringWithFormat:@"%d points",point];
//        }else{
//            pointLabel.text = [NSString stringWithFormat:@"%d point",point];
//        }
//        pointLabel.font = [UIFont fontWithName:@"AppleGothic" size:40];
//        pointLabel.textAlignment = UITextAlignmentCenter;
//        pointLabel.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:pointLabel];
        [self gameFinish];
    }
}

- (void)getWords:(NSMutableArray *)levelWordsAry{
    
    int j = 0;
    for (int i = 0; i < levelWordsAry.count; i++) {
        if ([ap.myDefaults boolForKey:levelWordsAry[i]]) {
            if ([ap.levelStr isEqualToString:@"Easy"]) {
                gameWordsAry[j] = levelWordsAry[i];
            }else if ([ap.levelStr isEqualToString:@"Normal"]){
                gameWordsAry[j] = levelWordsAry[i];
            }else{
                gameWordsAry[j] = levelWordsAry[i];
            }
            j++;
        }
    }
//    int randNum[levelWordsAry.count];
//    for (int l = 0; l < levelWordsAry.count; l++) {
//        randNum[l] = (int)levelWordsAry.count;
//    }
//    for (int m = 0; m < levelWordsAry.count; m++) {
//        randNum[m] = (int)arc4random_uniform((int)levelWordsAry.count);
//        for (int n = 0; n < levelWordsAry.count; n++) {
//            if (n == m) {
//                n++;
//            }
//            while (randNum[m] == randNum[n]) {
//                randNum[m] = (int)arc4random_uniform((int)levelWordsAry.count);
//                n = 0;
//            }
//        }
//    }
//    for (int i = 0; i < levelWordsAry.count - 10; i++) {
////        temp[i] = randNum[i + 10];
////        NSLog(@"%d",temp[i]);
//        tempAry[i] = levelWordsAry[randNum[i + 10]];
////        NSLog(@"levelWordsAry = %@\ntempAry = %@\n",levelWordsAry[randNum[i + 10]],tempAry[i]);
//    }
//    levelWordsAryCount = (int)levelWordsAry.count;
//    [_btn1 setTitle:levelWordsAry[randNum[0]]forState:UIControlStateNormal];
//    
//    [_btn2 setTitle:levelWordsAry[randNum[1]]forState:UIControlStateNormal];
//    
//    [_btn3 setTitle:levelWordsAry[randNum[2]]forState:UIControlStateNormal];
//    
//    [_btn4 setTitle:levelWordsAry[randNum[3]]forState:UIControlStateNormal];
//    
//    [_btn5 setTitle:levelWordsAry[randNum[4]]forState:UIControlStateNormal];
//    
//    [_btn6 setTitle:levelWordsAry[randNum[5]]forState:UIControlStateNormal];
//    
//    [_btn7 setTitle:levelWordsAry[randNum[6]]forState:UIControlStateNormal];
//    
//    [_btn8 setTitle:levelWordsAry[randNum[7]]forState:UIControlStateNormal];
//    
//    [_btn9 setTitle:levelWordsAry[randNum[8]]forState:UIControlStateNormal];
//    
//    [_btn10 setTitle:levelWordsAry[randNum[9]]forState:UIControlStateNormal];
//    
}

- (void)getRandWords{
    int randNum[gameWordsAry.count];
    for (int l = 0; l < gameWordsAry.count; l++) {
        randNum[l] = (int)gameWordsAry.count;
    }
    for (int m = 0; m < gameWordsAry.count; m++) {
        randNum[m] = (int)arc4random_uniform((int)gameWordsAry.count);
        for (int n = 0; n < gameWordsAry.count; n++) {
            if (n == m) {
                n++;
            }
            while (randNum[m] == randNum[n]) {
                randNum[m] = (int)arc4random_uniform((int)gameWordsAry.count);
                n = 0;
            }
        }
    }
    if (gameWordsAry.count >= 10) {
        for (int i = 0; i < gameWordsAry.count - 10; i++) {
            //        temp[i] = randNum[i + 10];
            //        NSLog(@"%d",temp[i]);
            tempAry[i] = gameWordsAry[randNum[i + 10]];
            //        NSLog(@"levelWordsAry = %@\ntempAry = %@\n",levelWordsAry[randNum[i + 10]],tempAry[i]);
        }
            //    levelWordsAryCount = (int)levelWordsAry.count;
        levelWordsAryCount = (int)gameWordsAry.count;
        [btn1 setTitle:gameWordsAry[randNum[0]]forState:UIControlStateNormal];
        [btn1.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn1.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn1.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn1.titleLabel.minimumScaleFactor = 8;
        btn1.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
    
        [btn2 setTitle:gameWordsAry[randNum[1]]forState:UIControlStateNormal];
        [btn2.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn2.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn2.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn2.titleLabel.minimumScaleFactor = 8;
        btn2.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
        [btn3 setTitle:gameWordsAry[randNum[2]]forState:UIControlStateNormal];
        [btn3.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn3.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn3.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn3.titleLabel.minimumScaleFactor = 8;
        btn3.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn4 setTitle:gameWordsAry[randNum[3]]forState:UIControlStateNormal];
        [btn4.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn4.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn4.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn4.titleLabel.minimumScaleFactor = 8;
        btn4.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn5 setTitle:gameWordsAry[randNum[4]]forState:UIControlStateNormal];
        [btn5.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn5.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn5.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn5.titleLabel.minimumScaleFactor = 8;
        btn5.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn6 setTitle:gameWordsAry[randNum[5]]forState:UIControlStateNormal];
        [btn6.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn6.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn6.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn6.titleLabel.minimumScaleFactor = 8;
        btn6.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn7 setTitle:gameWordsAry[randNum[6]]forState:UIControlStateNormal];
        [btn7.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn7.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn7.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn7.titleLabel.minimumScaleFactor = 8;
        btn7.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn8 setTitle:gameWordsAry[randNum[7]]forState:UIControlStateNormal];
        [btn8.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn8.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn8.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn8.titleLabel.minimumScaleFactor = 8;
        btn8.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn9 setTitle:gameWordsAry[randNum[8]]forState:UIControlStateNormal];
        [btn9.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn9.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn9.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn9.titleLabel.minimumScaleFactor = 8;
        btn9.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn10 setTitle:gameWordsAry[randNum[9]]forState:UIControlStateNormal];
        [btn10.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
        btn10.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn10.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn10.titleLabel.minimumScaleFactor = 8;
        btn10.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"10枚ないよ？" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alert show];
    }

}
- (void)judgeWords:(NSDictionary *) levelWordsDic{
    if ([[levelWordsDic objectForKey:tappedBtnStr1] isEqualToString:tappedBtnStr2]) {
        NSLog(@"correct");
        // 正解音
        [self.correctSound play];
        // 正解のボタン消す,新しいボタン出す
        for (int j = 0; j < 2; j++) {
            UIButton *pushedBtn = pushedBtnAry[j];
            pushedBtn.hidden = YES;
            if (j + 2 * correctCount < tempAry.count) {
                NSLog(@"tempAry = %@",tempAry[j + 2 * correctCount]);
                [pushedBtn setTitle:tempAry[j + 2 * correctCount] forState:UIControlStateNormal];
                pushedBtn.hidden = NO;
                pushedBtn.enabled = YES;
                pushedBtn.selected = NO;
            }
        }
        correctCount++;
        [pushedBtnAry removeAllObjects];
    }else{
        // 不正解音
        [self.wrongSound play];
        //解除
        for (int i = 0; i <= 9; i++) {
            UIButton *btn = btnAry[i];
            btn.enabled = YES;
            btn.selected = NO;
        }
        NSLog(@"not correct");
    }

}

- (void)judgeUserWords{
    if ([userKeyWordsAry containsObject:tappedBtnStr1]) {
        index1 = [self searchAry:userKeyWordsAry tappedBtn:tappedBtnStr1];
    }else{
        index1 = [self searchAry:userValueWordsAry tappedBtn:tappedBtnStr1];
    }
    if ([userValueWordsAry containsObject:tappedBtnStr2]) {
        index2 = [self searchAry:userValueWordsAry tappedBtn:tappedBtnStr2];
    }else{
        index2 = [self searchAry:userKeyWordsAry tappedBtn:tappedBtnStr2];
    }
    if (index1 == index2) {
        // 正解アクション
        NSLog(@"correct");
        // 正解音
        [self.correctSound play];
        // 正解のボタン消す,新しいボタン出す
        for (int j = 0; j < 2; j++) {
            UIButton *pushedBtn = pushedBtnAry[j];
            pushedBtn.hidden = YES;
            if (j + 2 * correctCount < tempAry.count) {
                NSLog(@"tempAry = %@",tempAry[j + 2 * correctCount]);
                [pushedBtn setTitle:tempAry[j + 2 * correctCount] forState:UIControlStateNormal];
                pushedBtn.hidden = NO;
                pushedBtn.enabled = YES;
                pushedBtn.selected = NO;
            }
        }
        correctCount++;
        [pushedBtnAry removeAllObjects];
    }else{
        // 不正解アクション
        // 不正解音
        [self.wrongSound play];
        //解除
        for (int i = 0; i <= 9; i++) {
            UIButton *btn = btnAry[i];
            btn.enabled = YES;
            btn.selected = NO;
        }
        NSLog(@"not correct");
    }
    
}

// タイマーアクション
-(void)TimerAction{
    if(countDown > 0){
        countDown--;
        [_timeLabel setText:[NSString stringWithFormat:@"%d",countDown]]; // ラベルに時間を表示
    }else{
        [timer invalidate]; // タイマーを停止する
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time over" message:@"You still have lots more to work on.." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alert show];
        NSLog(@"---------タイムオーバ-----------");
    }
}

-(void)gameFinish{
    [timer invalidate];
    [self GamecenterInit];
    [self submitScore:755 forCategory:@"996825589"];
    
    // 終わった時のラベル出す
    UILabel *finishedLabel = [[UILabel alloc] init];
    finishedLabel.frame = CGRectMake(self.view.frame.size.width / 4, self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 8);
    finishedLabel.text = @"finished!";
    finishedLabel.font = [UIFont fontWithName:@"AppleGothic" size:40];
    finishedLabel.textAlignment = NSTextAlignmentCenter;
    finishedLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:finishedLabel];
    
    // point
    int point = countDown;
    NSLog(@"point = %d",point);
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, self.view.frame.size.height / 4 + finishedLabel.frame.size.height, finishedLabel.frame.size.width, finishedLabel.frame.size.height)];
    if (point > 1) {
        pointLabel.text = [NSString stringWithFormat:@"%d points",point];
    }else{
        pointLabel.text = [NSString stringWithFormat:@"%d point",point];
    }
    pointLabel.font = [UIFont fontWithName:@"AppleGothic" size:40];
    pointLabel.textAlignment = NSTextAlignmentCenter;
    pointLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:pointLabel];
}

// ストーリボード表示
- (void)GamecenterInit {
    GKGameCenterViewController *leaderboardController = [GKGameCenterViewController new];
    if (nil != leaderboardController) {
        leaderboardController.gameCenterDelegate = self;
        leaderboardController.viewState = GKGameCenterViewControllerStateLeaderboards;
        [self presentViewController:leaderboardController animated:YES completion:nil];
    }
}


// ストーリボードを閉じる際に必要なメソッド

// GKLeaderboardViewControllerのDelegate
-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// GKAchievementViewControllerのDelegate
-(void)achievementViewControllerDidFinish:(GKGameCenterViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// GameCenter
-(void)submitScore:(int)score forCategory:(NSString*)category {
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:category];
    scoreReporter.value = score;
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
        if (error) {
            /* エラー処理 */
            NSLog(@"書き込めませんでした");
        }
    }];
}

- (NSInteger)searchAry:(NSArray *)ary tappedBtn:(NSString *) str{
    NSInteger index = 0;
    for (int i = 0; i <= ary.count; i++) {
        if ([ary[i] isEqualToString:str]) {
            index = i;
            break;
        }
    }
    return index;
}


@end
