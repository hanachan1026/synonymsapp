//
//  AppDelegate.m
//  SynonymsApp
//
//  Created by 花屋拓馬 on 2015/05/04.
//  Copyright (c) 2015年 Takuma Hanaya. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize wordsAry;
@synthesize easyWordsAry;
@synthesize normalWordsAry;
@synthesize hardWordsAry;
@synthesize allWordsAry;
@synthesize myDefaults;
@synthesize plistDic;
@synthesize levelStr;
@synthesize allWordsDic;
@synthesize easyWordsDic;
@synthesize normalWordsDic;
@synthesize hardWordsDic;
@synthesize numDefaults;
@synthesize numberOfData;
@synthesize userWordsAryCountDefaults;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初期化
    
    NSBundle *bundle1 = [NSBundle mainBundle];
    NSString *path1 = [bundle1 pathForResource:@"WordList" ofType:@"plist"];
//    //    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *dic1 = [NSDictionary dictionaryWithContentsOfFile:path1];
//    //    NSLog(@"dic1 = %@", dic1);
    allWordsDic = dic1[@"Word"];
////    NSLog(@"plistDic = %@",plistDic);
//    allWordsAry = plistDic.allKeys;
////    NSLog(@"allWordSAry = %@",allWordsAry);
//    wordsAry = [[NSMutableArray alloc] initWithCapacity:allWordsAry.count];
    
    // easy & normal & hard
    
    NSBundle *bundle2 = [NSBundle mainBundle];
    NSString *path2 = [bundle2 pathForResource:@"WordList2" ofType:@"plist"];
    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile:path2];
    plistDic = dic2[@"Word"];
//    NSLog(@"plistDic = %@",plistDic);
    easyWordsDic = plistDic[@"EasyWords"];
    normalWordsDic = plistDic[@"NormalWords"];
    hardWordsDic = plistDic[@"HardWords"];
    
//    NSLog(@"easyworddic = %@\normalworddic = %@\nhardwordsdic = %@",easyWordsDic,normalWordsDic,hardWordsDic);
    easyWordsAry = (NSMutableArray *)easyWordsDic.allKeys;
    normalWordsAry = (NSMutableArray *)normalWordsDic.allKeys;
    hardWordsAry = (NSMutableArray *)hardWordsDic.allKeys;
    allWordsAry = [[easyWordsAry arrayByAddingObjectsFromArray:normalWordsAry] arrayByAddingObjectsFromArray:hardWordsAry];
//    NSLog(@"allWordsAry = \n%@",allWordsAry);

    
    
    myDefaults = [NSUserDefaults standardUserDefaults];
    //初回起動時だけに発動するように
    NSUserDefaults *initDefaults = [NSUserDefaults standardUserDefaults];
    
    userWordsAryCountDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![initDefaults boolForKey:@"init"]) {
        [initDefaults setBool:YES forKey:@"init"];
        
        for (int i = 0; i < allWordsAry.count; i++) {
            // UserDefaultsを初期化定義する
            [myDefaults setBool:YES forKey:allWordsAry[i]];
//            NSLog(@"initial myDefaults = %@", [myDefaults objectForKey:allWordsAry[i]]);
        }
        // wordsAry initialize
//        wordsAry = (NSMutableArray *)allWordsAry;
//        NSLog(@"wordsAry = %@",wordsAry);
    }
    
    
// Game center のため
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){};
    
// core data のため
    numDefaults = [NSUserDefaults standardUserDefaults];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - coredata
+(id)sharedManager
{
    static AppDelegate * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sample.CoreDataExample" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserVocabs" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserVocabs.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Entity Access Methods
-(NSMutableArray *)all:(NSString *)entityName
{
    return [self fetch:entityName limit:0];
}

-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key
{
    return [self fetch:entityName sortKey:key limit:0];
}

-(NSMutableArray *)fetch:(NSString *)entityName limit:(int)limit
{
    return [self fetch:entityName sortKey:nil limit:limit];
}

-(NSMutableArray *)fetch:(NSString *)entityName sortKey:(NSString *)key limit:(int)limit
{
    NSManagedObjectContext* context = self.managedObjectContext;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    if(key != nil)
    {
        NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
        [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    }
    
    [request setFetchLimit:limit];
    
    NSError* error = nil;
    NSMutableArray* mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(mutableFetchResults == nil)
    {
        NSLog(@"Fetch Error");
    }
    return mutableFetchResults;
    
}


-(NSManagedObject *)entityForInsert:(NSString *)entityName
{
    NSManagedObjectContext* context = self.managedObjectContext;
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
}



@end
