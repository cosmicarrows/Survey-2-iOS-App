//
//  ResultsEightViewController.m
//  Survey
//
//  Created by Steve VanBrackle on 3/14/12.
//  Copyright (c) 2012 Georgia Perimeter College. All rights reserved.
//

#import "ResultsEightViewController.h"
#import "AppDelegate.h"
#import "CommentViewController.h"

@interface ResultsEightViewController ()

@end

@implementation ResultsEightViewController

@synthesize questionEightTableView = _questionEightTableView;
@synthesize selections = _selections;
@synthesize commentViewController = _commentViewController;

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
    
    self.questionEightTableView.backgroundColor = [UIColor clearColor];
    
    self.questionEightTableView.delegate = self;
    self.questionEightTableView.dataSource = self;
    
    self.selections = [[NSMutableArray alloc] init];
    
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    
    // Get all of the surveys into the selections array
    
    // Question 8, Comments, are at index 7
    
    for (int i = 0; i < [[delegate surveys] count]; i++) {
        
        [self.selections addObject:[[[delegate surveys] objectAtIndex:i] objectAtIndex:7]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.selections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    
    // Display the items in the selections array
    
    if ([[self.selections objectAtIndex:indexPath.row] isEqualToString:@""])
        cell.textLabel.text = @"No comment";
    else
        cell.textLabel.text = [self.selections objectAtIndex:indexPath.row];
        
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    NSString *tempString = [[NSString alloc] init];
    
    tempString = [NSString stringWithFormat:@"%@\n", cell.textLabel.text];
    
    [delegate.spreadsheet appendString:tempString];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CommentViewController *cvc = [segue destinationViewController];
    UITableViewCell *tvc = sender;
    
    cvc.detailItem = tvc.textLabel.text;            
}

- (NSData *)saveToFile;
{
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"SurveyResults.csv"];
    
    NSError *error;
    
    BOOL success = [[delegate spreadsheet] writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (success)
        return [delegate.spreadsheet dataUsingEncoding:NSUTF8StringEncoding];
    else 
        return nil;
}

- (IBAction)eMailData:(id)sender
{
    NSData *data = [self saveToFile];
    //[self saveToFile];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateStyle:NSDateFormatterShortStyle];
        
        NSString *dateString = [dateFormat stringFromDate:today];
        
        NSString *now = [NSString stringWithFormat:@"GPC Survey Results - %@", dateString];
        
        [mailer setSubject:now];
        
        //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"SurveyResults.csv"];

        
        [mailer addAttachmentData:data mimeType:@"text/csv" fileName:now];
        
        //NSArray *toRecipients = [NSArray arrayWithObjects:@"steve.vanbrackle@gpc.edu", nil];
        //[mailer setToRecipients:toRecipients];
        
        //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //NSData *imageData = UIImagePNGRepresentation(myImage);
        //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];	
        
        //NSString *emailBody = @"Have you seen the MobileTuts+ web site?";
        //[mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.questionEightTableView = nil;
    self.selections = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
