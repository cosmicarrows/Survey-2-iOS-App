//
//  ResultsSixViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/14/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "ResultsSixViewController.h"
#import "AppDelegate.h"

@interface ResultsSixViewController ()

@end

@implementation ResultsSixViewController

@synthesize questionSixTableView = _questionSixTableView;
@synthesize selections = _selections;
@synthesize uniqueSelections = _uniqueSelections;
@synthesize counts = _counts;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"survey-background-paper.png"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"survey-background-paper.png"]];
    
    self.questionSixTableView.backgroundColor = [UIColor clearColor];
    
    self.questionSixTableView.delegate = self;
    self.questionSixTableView.dataSource = self;
    
    
    self.selections = [[NSMutableArray alloc] init];
    self.uniqueSelections = [[NSArray alloc] init];
    
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    // Survey answers for question 6 returns an array of strings
    
    // The answers are at index 5
    
    for (int i = 0; i < [[delegate surveys] count]; i++) {
        
        [self.selections addObject:[[[delegate surveys] objectAtIndex:i] objectAtIndex:5]];
    }
    
    // Put the array of strings into a single array
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    for (NSArray *item in self.selections) {
        for (NSString *anotherItem in item)
            [items addObject:anotherItem];
        
    }
    
    
    // Use an NSSet to get the unique items from the selections array
    
    NSSet *mySet = [NSSet setWithArray:items];
    self.uniqueSelections = [mySet allObjects];
    
    // Sort the uniqueSelections array for display in the table view
    
    self.uniqueSelections = [self.uniqueSelections sortedArrayUsingSelector:@selector(compare:)];
    
    // Get a count of unique items in the selections array
    
    self.counts = [NSCountedSet setWithArray:items];
    
    totalCount = [items count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.uniqueSelections count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    
    // Display the items in the uniqueSelections array
    
    cell.textLabel.text = [self.uniqueSelections objectAtIndex:indexPath.row];
    
    // Get a count of the uniqueSelection from the count set
    
    NSUInteger count;
    
    count = [self.counts countForObject:[self.uniqueSelections objectAtIndex:indexPath.row]];
    
    // Calculate the percent of this item in the selections array
    
    float percent;
    
    percent = ((float)count/(float)totalCount) * 100;
    
    // Get a string to put into the detail text label
    
    NSString *percentString = [NSString stringWithFormat:@"%2.2f%%", percent];
    
    cell.detailTextLabel.text = percentString;
    
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    NSString *tempString = [[NSString alloc] init];
    
    tempString = [NSString stringWithFormat:@"%@,%@\n", cell.textLabel.text, percentString];
    
    [delegate.spreadsheet appendString:tempString];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //AppDelegate *delegate = [AppDelegate sharedAppDelegate];
   // NSLog(@"%@", delegate.spreadsheet);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.questionSixTableView = nil;
    self.selections = nil;
    self.uniqueSelections = nil;
    self.counts = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
