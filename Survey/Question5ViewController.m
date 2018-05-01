//
//  Question5ViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "Question5ViewController.h"
#import "AppDelegate.h"

@interface Question5ViewController ()

@end

@implementation Question5ViewController

@synthesize items;
@synthesize questionFiveTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"survey-background-paper.png"]];
    self.questionFiveTableView.backgroundColor = [UIColor clearColor];

    self.questionFiveTableView.delegate = self;
    self.questionFiveTableView.dataSource = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Question5" ofType:@"plist"];
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
    //UITableViewCell *tvc = [questionFiveTableView cellForRowAtIndexPath:indexPath];
    // tvc.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //tvc.backgroundColor = [UIColor colorWithRed:179.0/255.9 green:0.0 blue:38.0/255.0 alpha:1.0];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
        
    NSArray *selectedItemsPath = [self.questionFiveTableView indexPathsForSelectedRows];
    
    
    NSIndexPath *path;
    NSString *item;
    
    ///NSString *item = [self.questionThreeTableView cellForRowAtIndexPath:path].textLabel.text;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < selectedItemsPath.count; i++) {
        
        path = [selectedItemsPath objectAtIndex:i];
        item = [self.questionFiveTableView cellForRowAtIndexPath:path].textLabel.text;
        [array addObject:item];
    }
    
    [[delegate surveyAnswers] addObject:array];
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.items = nil;
    self.questionFiveTableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
