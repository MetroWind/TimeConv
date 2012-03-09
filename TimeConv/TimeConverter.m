//
//  TimeConverter.m
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "TimeConverter.h"

@implementation TimeConverter
{
    NSDate* TimeSrc;
    NSDate* TimeDest;
    NSDatePicker* SrcTimeView;   
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialize self.
        TimeSrc = [[NSDate alloc] init];
        TimeDest = [[NSDate alloc] init];
    }
    return self;
}

- (void) updateSrcView
{
    [SrcTimeView setDateValue: TimeSrc];
}

- (void) setSrcToNowByTimer: (NSTimer*) timer
{
    NSLog(@"Timer %@ requests to update src time.", timer);
    [self setSrcToNow];
    [self updateSrcView];
}

- (void) setSrcToNow
{
    TimeSrc = [NSDate date];
}


- (void) setSrcView: (id) view
{
    SrcTimeView = view;
}

@end
