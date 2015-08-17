//
//  GameViewController.h
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@interface GameViewController : UIViewController <GKGameCenterControllerDelegate>



@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property AVAudioPlayer *correctSound;
@property AVAudioPlayer *wrongSound;


@end
