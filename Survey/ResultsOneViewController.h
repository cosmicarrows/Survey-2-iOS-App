//
//  ResultsOneViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/14/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsOneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *whichResults;

@property (strong, nonatomic) IBOutlet UITableView *resultsOneTableView;

@property (strong, nonatomic) NSArray *uniqueSelections;

@property (strong, nonatomic) NSMutableArray *selections;

@property (strong, nonatomic) NSCountedSet *counts;

@property (strong, nonatomic) IBOutlet UILabel *numberOfItems;


@end
