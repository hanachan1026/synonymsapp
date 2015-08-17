//
//  MainViewController.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

#define MARGIN 10
#define MY_KEY @"myStr"
@interface MainViewController (){
    AppDelegate *ap;
    ADBannerView *_adView;
    BOOL _isVisible;
    
    UILabel *synonymsLabel;
    UIButton *easyBtn;
    UIButton *normalBtn;
    UIButton *hardBtn;
    UIButton *userBtn;
    UIButton *optionBtn;
    UITextField *_textField;
    NSString *_textFieldText;
    NSUserDefaults *_playerDefaults;
    NSString *_temp;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初期化
    
    // InterfaceBuilderを使わずに UISearchBar を追加
    UISearchBar *searchBar;
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 16, self.view.bounds.size.width, 12.0f)];
    searchBar.showsCancelButton = YES;
    searchBar.tintColor = [UIColor lightGrayColor];
    searchBar.delegate = self;
    searchBar.placeholder = @"検索ワードを入力してください";
    [searchBar sizeToFit];

    CGSize size = self.view.frame.size;
    // titleLabel
    synonymsLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width / 8, size.height / 10 + 5, size.width * 3 / 4, size.height / 9)];
    [synonymsLabel setText:@"Synonyms"];
    [synonymsLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:50]];
    synonymsLabel.textColor = [UIColor grayColor];
    synonymsLabel.textAlignment = NSTextAlignmentCenter;
    synonymsLabel.adjustsFontSizeToFitWidth = YES;
    synonymsLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    synonymsLabel.minimumScaleFactor = 8;
    synonymsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    easyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    easyBtn.frame = CGRectMake(size.width / 4, size.height * 1 / 4 - 5, size.width / 2, size.height / 9);
    [easyBtn setTitle:@"Easy" forState:UIControlStateNormal];
    [easyBtn.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
    [easyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    easyBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    easyBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    easyBtn.titleLabel.minimumScaleFactor = 8;
    easyBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    easyBtn.backgroundColor = [UIColor yellowColor];
    [easyBtn addTarget:self action:@selector(pushEasy:) forControlEvents:UIControlEventTouchUpInside];
    
    float moveHeight = easyBtn.frame.size.height + MARGIN;
    
    normalBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [normalBtn setTitle:@"Normal" forState:UIControlStateNormal];
    [normalBtn.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
    [normalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    normalBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    normalBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    normalBtn.titleLabel.minimumScaleFactor = 8;
    normalBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    normalBtn.frame = CGRectMake(size.width / 4, size.height * 1 / 4 - 5 + moveHeight, size.width / 2, size.height / 9);
    normalBtn.backgroundColor = [UIColor blueColor];
    [normalBtn addTarget:self action:@selector(pushNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    hardBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [hardBtn setTitle:@"Hard" forState:UIControlStateNormal];
    [hardBtn.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
    [hardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    hardBtn.frame = CGRectMake(size.width / 4, size.height * 1 / 4 - 5 + moveHeight * 2, size.width / 2, size.height / 9);
    hardBtn.backgroundColor = [UIColor redColor];
    [hardBtn addTarget:self action:@selector(pushHard:) forControlEvents:UIControlEventTouchUpInside];
    
    userBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [userBtn setTitle:@"User" forState:UIControlStateNormal];
    [userBtn.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:35]];
    [userBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    userBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    userBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    userBtn.titleLabel.minimumScaleFactor = 8;
    userBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    userBtn.frame = CGRectMake(size.width / 4, size.height * 1 / 4 - 5 + moveHeight * 3, size.width / 2, size.height / 9);
    userBtn.backgroundColor = [UIColor greenColor];
    [userBtn addTarget:self action:@selector(pushUser:) forControlEvents:UIControlEventTouchUpInside];
    
    optionBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [optionBtn setTitle:@"Card List" forState:UIControlStateNormal];
//    [optionBtn.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]];
//    [optionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    optionBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    optionBtn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    optionBtn.titleLabel.minimumScaleFactor = 8;
    optionBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    optionBtn.frame = CGRectMake(size.width * 5 / 7, size.height * 1 / 4 - 5 + moveHeight * 37 / 10 + MARGIN * 2, size.width / 3, size.height / 15);
//    optionBtn.backgroundColor = [UIColor grayColor];
    [optionBtn addTarget:self action:@selector(pushOption:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width / 7, size.height * 1 / 4 + moveHeight * 4, size.width / 4, size.height / 17)];
    [playerLabel setText:@"Player:"];
    [playerLabel setFont:[UIFont systemFontOfSize:25]];
    playerLabel.textColor = [UIColor blackColor];
    playerLabel.textAlignment = NSTextAlignmentLeft;
    playerLabel.adjustsFontSizeToFitWidth = YES;
    playerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    playerLabel.minimumScaleFactor = 8;
    playerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    playerLabel.backgroundColor = [UIColor brownColor];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(size.width * 2 / 5, size.height * 1 / 4 + moveHeight * 4, size.width * 2 / 5, size.height / 17)];
    _textField.placeholder = @"Name";
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [_textField addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventEditingDidEnd];
    _textField.delegate = self;
    _textField.text = [_playerDefaults objectForKey:MY_KEY];
    
    _adView = [[ADBannerView alloc] init];
    // 場所を決定
    _adView.frame = CGRectMake(0, self.view.frame.size.height - _adView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height / 25);
    
    _adView.alpha = 0.0;
    _adView.delegate = self;
    
    //画面本体に追加
    [self.view addSubview:_adView];
    // まだ表示されてない
    _isVisible = NO;
    ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view addSubview:searchBar];
    [self.view addSubview:synonymsLabel];
    [self.view addSubview:easyBtn];
    [self.view addSubview:normalBtn];
    [self.view addSubview:hardBtn];
    [self.view addSubview:userBtn];
    [self.view addSubview:optionBtn];
    [self.view addSubview:playerLabel];
    [self.view addSubview:_textField];
    
    _playerDefaults = [NSUserDefaults standardUserDefaults];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_isVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:nil];
    
        [UIView setAnimationDuration:0.3];
    
        banner.frame = CGRectOffset(banner.frame, 0, 0);
    
        banner.alpha = 1.0;
    
        [UIView commitAnimations];
        
        //表示したのでisVisibleをYESにする
        _isVisible = YES; //←追加行2
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (_isVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
    
        [UIView setAnimationDuration:0.3];
    
        banner.frame = CGRectOffset(banner.frame, 0, -CGRectGetHeight(banner.frame));
        banner.alpha = 0.0;
        [UIView commitAnimations];
        
        //非表示したのでisVisibleをNOにする
        _isVisible = NO; //←追加行2
    } //←追加行3
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushEasy:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    ap.levelStr = sender_btn.titleLabel.text;
//    NSLog(@"pushしたとき levelStr = %@\n easyWordsAry = %@",ap.levelStr,ap.easyWordsAry);
    GameViewController *GameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GVC"];
    [self presentViewController:GameViewController animated:YES completion:nil];
    
}

- (IBAction)pushNormal:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    ap.levelStr = sender_btn.titleLabel.text;
    GameViewController *GameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GVC"];
    [self presentViewController:GameViewController animated:YES completion:nil];
}

- (IBAction)pushHard:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    ap.levelStr = sender_btn.titleLabel.text;
    GameViewController *GameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GVC"];
    [self presentViewController:GameViewController animated:YES completion:nil];
}

- (IBAction)pushUser:(id)sender {
    UIButton *sender_btn = (UIButton *)sender;
    ap.levelStr = sender_btn.titleLabel.text;
    GameViewController *GameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GVC"];
    [self presentViewController:GameViewController animated:YES completion:nil];
}

- (IBAction)pushOption:(id)sender {
    OptionViewController *OptionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OVC"];
    [self presentViewController:OptionViewController animated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *term = searchBar.text;
    UIReferenceLibraryViewController *controller = [[UIReferenceLibraryViewController alloc] initWithTerm:term];
    [self presentViewController:controller animated:YES completion:NULL];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    _textFieldText = _textField.text;
    [_playerDefaults setObject:_textFieldText forKey:MY_KEY];
    _temp = [_playerDefaults objectForKey:MY_KEY];
    NSLog(@"player = %@",_temp);
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
//    NSLog(@"viewWillAppear");
    _textField.text = [_playerDefaults objectForKey:MY_KEY];
}


@end
