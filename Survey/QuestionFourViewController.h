//
//  QuestionFourViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionFourViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *items;

@property (weak, nonatomic) IBOutlet UITableView *questionFourTableView;

@end
