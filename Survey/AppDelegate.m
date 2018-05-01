//
//  AppDelegate.m
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "AppDelegate.h"

static AppDelegate *sharedInstance;

@implementation AppDelegate

@synthesize window = _window;

@synthesize surveys = _surveys;
@synthesize surveyAnswers = _surveyAnswers;
@synthesize spreadsheet = _spreadsheet;

+ (AppDelegate *)sharedAppDelegate
{
    return sharedInstance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    sharedInstance = self;
    
    self.surveyAnswers = [[NSMutableArray alloc] init];
    self.surveys = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *resultsFilename = [documentsDirectory stringByAppendingPathComponent:@"SurveyResults.csv"];
    
    NSError *error;
    
    if ([fileManager fileExistsAtPath:resultsFilename])
        [fileManager removeItemAtPath:resultsFilename error:&error];
    
    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"Surveys"];
    
    if ([fileManager fileExistsAtPath:filename]) {
        
        self.surveys = [NSArray arrayWithContentsOfFile:filename];
    }
    
    self.spreadsheet = [[NSMutableString alloc] init];
        
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"Surveys"];
    
    [self.surveys writeToFile:filename atomically:YES];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
