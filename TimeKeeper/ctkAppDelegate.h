//
//  ctkAppDelegate.h
//  TimeKeeper
//
//  Created by Philip Clifton on 19/05/2013.
//  Copyright (c) 2013 Philip Clifton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ctkAppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSScrollView *timeTable;

// Popuplist Function
@property (weak) IBOutlet NSPopUpButton *projectPopupList;
@property (weak) IBOutlet NSPopUpButton *userPopupList;

// Timer Fuctions
@property (strong) IBOutlet NSTextField *stopwatchLabel;
- (IBAction)onStartPress:(id)sender;
- (IBAction)onStopPress:(id)sender;
@property (strong, nonatomic) NSTimer *stopWatchTimer; 
@property (strong, nonatomic) NSDate *startDate;
@property (weak) IBOutlet NSTextField *lastRecordedTimer;
@property (weak) IBOutlet NSButton *startTimerButton;
@property (weak) IBOutlet NSButton *stopTimerButton;
@property (weak) IBOutlet NSTextFieldCell *postSent;

// Timer Submit
- (IBAction)postTiming:(id)sender;


@end

