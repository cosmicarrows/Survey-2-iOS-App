//
//  FirstViewController.h
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *organization;

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) IBOutlet UITableView *questionTwoTableView;

//- (IBAction)storeData;

@end
