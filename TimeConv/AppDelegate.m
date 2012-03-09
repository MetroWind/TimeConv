//
//  AppDelegate.m
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "TimeController.h"
#import "TimeConverter.h"
#import "AppDelegate.h"

@implementation AppDelegate
{
    TimeController* TimeControl;
    TimeConverter* TimeConv;
}

@synthesize window;
@synthesize SrcTimeView;
@synthesize SrcTimeZoneView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    TimeControl = [[TimeController alloc] init];
    TimeConv = [[TimeConverter alloc] init];
    
    [TimeControl setConverter: TimeConv];
    [TimeConv setSrcView: SrcTimeView];
    [TimeControl startUpdatingCurrentTime];
}

@end
