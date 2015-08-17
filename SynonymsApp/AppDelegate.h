//
//  AppDelegate.h
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <CoreData/CoreData.h>
#import "UserWords.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableArray *wordsAry;
    NSMutableArray *easyWordsAry;
    NSMutableArray *normalWordsAry;
    NSMutableArray *hardWordsAry;
    NSArray *allWordsAry;
    NSUserDefaults *myDefaults;
    NSDictionary *plistDic;
    NSString *levelStr;
    NSDictionary *allWordsDic;
    NSDictionary *easyWordsDic;
    NSDictionary *normalWordsDic;
    NSDictionary *hardWordsDic;
//    NSMutableArray *userWordsAry;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *wordsAry;
@property (strong, nonatomic) NSMutableArray *easyWordsAry;
@property (strong, nonatomic) NSMutableArray *normalWordsAry;
@property (strong, nonatomic) NSMutableArray *hardWordsAry;
@property (strong, nonatomic) NSArray *allWordsAry;
@property (strong, nonatomic) NSUserDefaults *myDefaults;
@property (strong, nonatomic) NSDictionary *plistDic;
@property (strong, nonatomic) NSString *levelStr;
@property (strong, nonatomic) NSDictionary *allWordsDic;
@property (strong, nonatomic) NSDictionary *easyWordsDic;
@property (strong, nonatomic) NSDictionary *normalWordsDic;
@property (strong, nonatomic) NSDictionary *hardWordsDic;
@property (strong, nonatomic) NSUserDefaults *numDefaults;
@property int numberOfData;
@property (strong, nonatomic) NSUserDefaults *userWordsAryCountDefaults;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (strong, nonatomic) AppDelegate *manager;
//@property (strong, nonatomic) UserWordAsKey *UWAK;
//@property (strong, nonatomic) UserWordAsValue *UWAV;

//@property (strong, nonatomic) NSMutableArray *userWordsAry;


- (void)saveContext;

-(NSMutableArray *)all:(NSString *)entityName;
-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key;
-(NSMutableArray *)fetch:(NSString *)entityName limit:(int)limit;
-(NSMutableArray *)fetch:(NSString *)entityName sortKey:(NSString *)key limit:(int)limit;
-(NSManagedObject *)entityForInsert:(NSString *)entityName;
- (NSURL *)applicationDocumentsDirectory;
+ (id)sharedManager;



@end

