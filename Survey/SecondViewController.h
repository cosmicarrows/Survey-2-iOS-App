//
//  SecondViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SecondViewController : UIViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate>
{
    int totalCount;
}

@property (strong, nonatomic)  UIButton *localResults;
@property (strong, nonatomic)  UIButton *totalResults;

@property (strong, nonatomic) NSMutableString *resultsString;

- (IBAction)showAlert:(id)sender;
- (IBAction)eMailData:(id)sender;

@end
