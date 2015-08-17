//
//  RegisterViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/28.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserWords.h"
#import "AppDelegate.h"
#import "UserCardListViewController.h"
#import "OptionViewController.h"

@interface RegisterViewController (){
    AppDelegate *ap;
    NSNumber *dataNum;
    int userWordsAryCountInt;
    
    UIButton *backBtn;
    UIButton *registerBtn;
    UITextField *UserTextField1;
    UITextField *UserTextField2;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size = self.view.frame.size;
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width / 10, size.height / 14, size.width / 6, size.height / 20)];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    [backBtn addTarget:self action:@selector(pushBack:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    backBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    backBtn.titleLabel.minimumScaleFactor = 8;
    backBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width * 5 / 8 - 5, size.height * 4 / 5, size.width * 1 / 4, size.height / 10)];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor blueColor];
//    [registerBtn.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]];
    [registerBtn addTarget:self action:@selector(tapRegister:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    registerBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    registerBtn.titleLabel.minimumScaleFactor = 8;
    registerBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UserTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(size.width / 4, size.height * 1 / 3, size.width / 2, 30)];
    UserTextField1.placeholder = @"Word";
    UserTextField1.textAlignment = NSTextAlignmentCenter;
    UserTextField1.borderStyle = UITextBorderStyleRoundedRect;
    [UserTextField1 addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventEditingDidEnd];
    UserTextField1.delegate = self;
    
    UserTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(size.width / 4, size.height * 3 / 5, size.width / 2, 30)];
    UserTextField2.placeholder = @"Synonym";
    UserTextField2.textAlignment = NSTextAlignmentCenter;
    UserTextField2.borderStyle = UITextBorderStyleRoundedRect;
    [UserTextField2 addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventEditingDidEnd];
    UserTextField2.delegate = self;
    
    ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    userWordsAryCountInt = (int)[ap.userWordsAryCountDefaults integerForKey:@"userWordsAryCount"];
    if (userWordsAryCountInt == 25) {
        registerBtn.enabled = NO;
    } else {
        registerBtn.enabled = YES;
    }
    [self.view addSubview:backBtn];
    [self.view addSubview:registerBtn];
    [self.view addSubview:UserTextField1];
    [self.view addSubview:UserTextField2];
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
- (IBAction)pushBack:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    OptionViewController *OptionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OVC"];
    [self presentViewController:OptionViewController animated:YES completion:nil];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)tapReturnKey1:(id)sender {
    [UserTextField1 resignFirstResponder];
}

- (IBAction)tapReturnKey2:(id)sender {
    [UserTextField2 resignFirstResponder];
}

- (IBAction)tapRegister:(id)sender {
    if ([UserTextField1.text isEqualToString:@""] || [UserTextField2.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"ERROR";
        alert.message = @"文字を入力してください";
        alert.delegate = self;
        [alert addButtonWithTitle:@"cancel"];
        [alert show];
    }else {
        AppDelegate *manager = [AppDelegate sharedManager];
        UserWords *userWords = (UserWords *)[manager entityForInsert:@"UserWords"];
        ap.numberOfData = (int)[ap.numDefaults integerForKey:@"dataInt"];
        NSLog(@"numberOfData = %i", ap.numberOfData);
    
        ap.numberOfData += 1;
//        NSLog(@"i += 1 = %i",i);
    
        [ap.numDefaults setInteger:ap.numberOfData forKey:@"dataInt"];
//    NSLog(@"before synchronize numDefault = %zd", [numDefaults integerForKey:@"dataInt"]);
        [ap.numDefaults synchronize];
        NSLog(@"numDefault = %zd", [ap.numDefaults integerForKey:@"dataInt"]);
    
        userWords.userWordsId = [NSNumber numberWithInt:ap.numberOfData];
        NSLog(@"userWord.dataNum = %@",userWords.userWordsId);
    
        userWords.keyWord = UserTextField1.text;
        userWords.valueWord = UserTextField2.text;
        [manager saveContext];
    
        UserTextField1.text = @"";
        UserTextField2.text = @"";
        NSLog(@"userWordsAryCountDefaults = %ld",[ap.userWordsAryCountDefaults integerForKey:@"userWordsAryCount"]);
        
        NSLog(@"userWordsAryCountInt = %d",userWordsAryCountInt);
        userWordsAryCountInt++;
        if (userWordsAryCountInt == 25) {
            NSLog(@"maximum number of data");
            registerBtn.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] init];
            alert.title = @"ALERT";
            alert.message = @"Reached maximum number of data";
            alert.delegate = self;
            [alert addButtonWithTitle:@"cancel"];
            [alert show];
            
            
        }
    }
//    ap.result1 = [manager all:@"UserWordAsKey" sortKey:@"keyWord"];
//    ap.result2 = [manager all:@"UserWordAsValue" sortKey:@"valueWord"];
}
@end
