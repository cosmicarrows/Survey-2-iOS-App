//
//  QuestionSixViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionSixViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *items;

@property (weak, nonatomic) IBOutlet UITableView *questionSixTableView;

@end
