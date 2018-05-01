//
//  AppDelegate.h
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// An array to hold all surveys
@property (strong, nonatomic) NSMutableArray *surveys;

// An array to hold the current survey
@property (strong, nonatomic) NSMutableArray *surveyAnswers;

@property (strong, nonatomic) NSMutableString *spreadsheet;

+ (AppDelegate *)sharedAppDelegate;


@end
