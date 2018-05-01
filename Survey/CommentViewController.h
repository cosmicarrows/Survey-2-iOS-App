//
//  CommentViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/15/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITextView *comment;

@end
