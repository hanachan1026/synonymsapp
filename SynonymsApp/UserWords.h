//
//  UserWords.h
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/06/02.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserWords : NSManagedObject

@property (nonatomic, retain) NSString * keyWord;
@property (nonatomic, retain) NSString * valueWord;
@property (nonatomic, retain) NSNumber * userWordsId;

@end
