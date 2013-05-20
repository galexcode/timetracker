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
    // Create Dropdown Project List
    NSArray *projects = [ctkDataApi makeProjectsRequest];
    [_projectPopupList removeAllItems];
    [_projectPopupList addItemsWithTitles:projects];
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
    
}
@end
