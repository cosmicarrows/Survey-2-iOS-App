//
//  QuestionEightViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionEightViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *comments;

@property (strong, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneClicked:(id)sender;
@end
