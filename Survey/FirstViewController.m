//
//  FirstViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize organization;
@synthesize questionTwoTableView;
@synthesize items;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.organization becomeFirstResponder];
    
    self.questionTwoTableView.delegate = self;
    self.questionTwoTableView.dataSource = self;
    
    //UIColor *gpcYellow = [[UIColor alloc] initWithRed:255.0f/255.0f green:204.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
	//self.view.backgroundColor = gpcYellow;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"survey-background-paper.png"]];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:146.0/255.0 green:0.0 blue:34.0/255.0 alpha:1.0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Question2" ofType:@"plist"];
    self.items = [[NSArray alloc] initWithContentsOfFile:path];
    
    self.questionTwoTableView.backgroundColor = [UIColor clearColor];
    
    [self.organization becomeFirstResponder];
    
    /*
     
     Remove all objects from surveys
     Read in file from surveys
     
     Write out file after survey is completed
     Remove all objects from surveyAnswers
     
    */
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

/*
- (IBAction)storeData
{
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    if (!delegate)
        NSLog(@"No delegate");
    
    [[delegate surveyAnswers] addObject:self.organization.text];
    
    NSLog(@"%@", [delegate surveyAnswers]);
}
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    [[delegate surveyAnswers] removeAllObjects];
    
    [[delegate surveyAnswers] addObject:self.organization.text];
    
    NSArray *selectedItemsPath = [self.questionTwoTableView indexPathsForSelectedRows];

    
    NSIndexPath *path;
    NSString *item;
    
    ///NSString *item = [self.questionThreeTableView cellForRowAtIndexPath:path].textLabel.text;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < selectedItemsPath.count; i++) {
        
        path = [selectedItemsPath objectAtIndex:i];
        item = [self.questionTwoTableView cellForRowAtIndexPath:path].textLabel.text;
        [array addObject:item];
        [self.questionTwoTableView deselectRowAtIndexPath:path animated:NO];
    }
    
    [[delegate surveyAnswers] addObject:array];
    
    self.organization.text = nil;
        
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.organization = nil;
    self.questionTwoTableView = nil;
    self.items = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
