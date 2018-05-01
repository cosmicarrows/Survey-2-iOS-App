//
//  ResultsOneViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/14/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "ResultsOneViewController.h"
#import "AppDelegate.h"

@interface ResultsOneViewController ()

@end

@implementation ResultsOneViewController

@synthesize whichResults = _whichResults;
@synthesize resultsOneTableView = _resultsOneTableView;
@synthesize uniqueSelections = _uniqueSelections;
@synthesize selections = _selections;
//@synthesize uniqueDict = _uniqueDict;
//@synthesize percentages = _percentages;
@synthesize counts = _counts;
@synthesize numberOfItems= _numberOfItems;

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
    
    self.resultsOneTableView.backgroundColor = [UIColor clearColor];
    
    self.resultsOneTableView.delegate = self;
    self.resultsOneTableView.dataSource = self;
    
    self.selections = [[NSMutableArray alloc] init];
    self.uniqueSelections = [[NSArray alloc] init];
    //self.uniqueDict = [[NSMutableDictionary alloc] init];
    //self.percentages = [[NSMutableArray alloc] init];
    
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    
    // Get all of the surveys into the selections array
    
    for (int i = 0; i < [[delegate surveys] count]; i++) {
        
        [self.selections addObject:[[[delegate surveys] objectAtIndex:i] objectAtIndex:0]];
    }
    
    for (int i = 0; i < [self.selections count]; i++) {
        
        [[self.selections objectAtIndex:i] capitalizedString];
    }
    
    NSNumber *selectionsCount = [NSNumber numberWithInt:[self.selections count]]; 
    
    self.numberOfItems.text = [selectionsCount stringValue];
                          
    //[self.selections sortUsingSelector:@selector(compare:)];
   
    // Use an NSSet to get the unique items from the selections array
    
    NSSet *mySet = [NSSet setWithArray:self.selections];
    self.uniqueSelections = [mySet allObjects];
    
    // Sort the uniqueSelections array for display in the table view
    
    //self.uniqueSelections = [self.uniqueSelections sortedArrayUsingSelector:@selector(compare:)];
    self.uniqueSelections = [self.uniqueSelections sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    // Get a count of unique items in the selections array

    self.counts = [NSCountedSet setWithArray:self.selections];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.uniqueSelections count];
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
    
    percent = ((float)count/(float)[self.selections count]) * 100;
    
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
    //NSLog(@"%@", delegate.spreadsheet);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.whichResults = nil;
    self.resultsOneTableView = nil;
    self.uniqueSelections = nil;
    self.selections = nil;
    self.counts = nil;
    self.numberOfItems = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
