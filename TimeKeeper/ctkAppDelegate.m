//
//  ctkAppDelegate.m
//  TimeKeeper
//
//  Created by Philip Clifton on 19/05/2013.
//  Copyright (c) 2013 Philip Clifton. All rights reserved.
//

#import "ctkAppDelegate.h"
#import "ctkDataApi.h"

@implementation ctkAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Create Dropdown User List
    NSArray *users = [ctkDataApi makeUserRequest];
    [_userPopupList removeAllItems];
    
    for (NSDictionary *user in users) {
        NSString *username = [user objectForKey:@"name"];
        [_userPopupList addItemWithTitle:username];
    }
    
    // Create Dropdown Project List
    NSArray *projects = [ctkDataApi makeProjectsRequest];
    [_projectPopupList removeAllItems];
    
    for (NSDictionary *item in projects) {
        NSString *projectName = [item objectForKey:@"name"];
        [_projectPopupList addItemWithTitle:projectName];
    }
}


// TIMER FUNCTIONS
////////////////////////////////////////////////////////////////////////
- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.stringValue = timeString;
}

- (IBAction)onStartPress:(id)sender {
    self.startDate = [NSDate date];
    
    self.postSent.stringValue = [NSString stringWithFormat:@""];
    
    // Disable start button & Enable Stop Button
    self.startTimerButton.enabled = NO;
    self.stopTimerButton.enabled = YES;
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (IBAction)onStopPress:(id)sender {
    
    // Enable start button & Disable Stop Button
    self.startTimerButton.enabled = YES;
    self.stopTimerButton.enabled = NO;
    
    // Set the last recorded timer as the current timer
    self.lastRecordedTimer.stringValue = self.stopwatchLabel.stringValue;
    
    // Kill current timer
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
}


// Submit Time
////////////////////////////////////////////////////////////////////////
- (IBAction)postTiming:(id)sender {
    
    NSString *timer = self.lastRecordedTimer.stringValue;
    NSString *project = self.projectPopupList.titleOfSelectedItem;
    NSString *account = self.userPopupList.titleOfSelectedItem;
    
    NSString *post = [NSString stringWithFormat:@"username=%@&project=%@&hours=%@&role_id=4",account,project,timer];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://local.timesheets/index.php/api/add_project_time"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:returnData
                          options:kNilOptions
                          error:Nil];

//    NSLog(@"users=%@", [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]);

    
//    NSString *success = [json objectForKey:@"success"];
//    NSString *match = [[NSString alloc] initWithFormat:@"1"];

    self.postSent.stringValue = [NSString stringWithFormat:@"Post Sent"];

}
@end
