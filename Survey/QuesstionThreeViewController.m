//
//  QuesstionThreeViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "QuesstionThreeViewController.h"
#import "AppDelegate.h"

@interface QuesstionThreeViewController ()

@end

@implementation QuesstionThreeViewController
@synthesize items;
@synthesize questionThreeTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"survey-background-paper.png"]];
    self.questionThreeTableView.backgroundColor = [UIColor clearColor];
 
    self.questionThreeTableView.delegate = self;
    self.questionThreeTableView.dataSource = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Question3" ofType:@"plist"];
    self.items = [[NSArray alloc] initWithContentsOfFile:path];
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.items count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *tvc = [questionThreeTableView cellForRowAtIndexPath:indexPath];
   // tvc.accessoryType = UITableViewCellAccessoryCheckmark;
    
   // tvc.backgroundColor = [UIColor colorWithRed:163.0/255.0 green:2.0/255.0 blue:52.0/255.0 alpha:1.0];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    NSArray *selectedItems = [self.questionThreeTableView indexPathsForSelectedRows];
    
    //NSLog(@"%@", selectedItems);  
    
    NSIndexPath *path;
    NSString *item;
    
    ///NSString *item = [self.questionThreeTableView cellForRowAtIndexPath:path].textLabel.text;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    for (int i = 0; i < selectedItems.count; i++) {
        
        path = [selectedItems objectAtIndex:i];
        item = [self.questionThreeTableView cellForRowAtIndexPath:path].textLabel.text;
        [array addObject:item];
    }
    
    [[delegate surveyAnswers] addObject:array];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.items = nil;
    self.questionThreeTableView = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
