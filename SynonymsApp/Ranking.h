//
//  Ranking.h
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/06/25.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ranking : NSManagedObject

@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) NSString * players;

@end
