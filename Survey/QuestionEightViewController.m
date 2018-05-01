//
//  QuestionEightViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/1/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "QuestionEightViewController.h"
#import "AppDelegate.h"

@interface QuestionEightViewController ()

@end

@implementation QuestionEightViewController

@synthesize comments;
@synthesize doneButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"survey-background-paper.png"]];
    self.navigationItem.hidesBackButton = YES;

    [self.comments becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.comments = nil;
    self.doneButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneClicked:(id)sender {
    
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    [[delegate surveyAnswers] addObject:self.comments.text];
    
    [self.comments resignFirstResponder];
    
    [[delegate surveys] addObject:[[delegate surveyAnswers] copy]];
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"Surveys"];
    
    [[delegate surveys] writeToFile:filename atomically:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
