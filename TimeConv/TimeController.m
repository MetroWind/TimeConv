//
//  TimeController.m
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "TimeConverter.h"
#import "TimeController.h"

@implementation TimeController
{
    NSTimer* SrcUpdateTimer;
    TimeConverter* TimeConv;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialize self.
    }
    return self;
}

- (void) setConverter: (id) converter
{
    TimeConv = converter;
}

- (void) startUpdatingCurrentTime
{
    SrcUpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval: 0.5
                                     target: TimeConv
                                   selector: @selector(setSrcToNowByTimer:)
                                   userInfo: [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"]
                                    repeats: YES];
    // [SrcUpdateTimer fire];
    NSLog(@"Timer fired.");
}

- (void) stopUpdatingCurrentTime
{
    [SrcUpdateTimer invalidate];
}

@end
