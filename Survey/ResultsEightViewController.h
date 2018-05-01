//
//  ResultsEightViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/14/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CommentViewController.h"

@interface ResultsEightViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *questionEightTableView;

@property (strong, nonatomic) NSMutableArray *selections;

@property (strong, nonatomic) CommentViewController *commentViewController;

- (IBAction)eMailData:(id)sender;


@end
