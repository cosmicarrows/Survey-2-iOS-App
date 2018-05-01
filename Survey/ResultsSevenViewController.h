//
//  ResultsSevenViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/14/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsSevenViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    int totalCount;
}

@property (strong, nonatomic) IBOutlet UITableView *questionSevenTableView;

@property (strong, nonatomic) NSMutableArray *selections;

@property (strong, nonatomic) NSArray *uniqueSelections;

@property (strong, nonatomic) NSCountedSet *counts;

@end
