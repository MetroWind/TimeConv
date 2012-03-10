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
    TimeConverter* TimeConv;
    
    id SrcTimeView;
    id SrcZoneView;
    id DestTimeView;
    id DestZoneView;
    
    NSTimer* UpdateTimer;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialize self.
        NSLog(@"Time controller initialized.");
    }
    return self;
}

- (void) setSrcView: (id) src_view srcZoneView: (id) src_zone_view
{
    SrcTimeView = src_view;
    SrcZoneView = src_zone_view;
}

- (void) setDestView: (id) dest_view destZoneView: (id) dest_zone_view
{
    DestTimeView = dest_view;
    DestZoneView = dest_zone_view;
}

- (void) setConverter: (id) converter
{
    TimeConv = converter;
}

- (void) shortSrcZone: (bool) shortp
{
    [TimeConv genSrcZoneViewList: shortp];
}

- (void) shortDestZone: (bool) shortp
{
    [TimeConv genDestZoneViewList: shortp];
}

//-(void) controlTextDidChange: (NSNotification*) notice
//{
//    id WhoChanged = [notice object];
//    bool Success;
//    if([[WhoChanged identifier] compare: @"ZoneSrc"] == NSOrderedSame)
//    {
//        NSLog(@"Changing zone while typing...");
//        Success = [TimeConv setSrcZoneWithStr:
//                   [WhoChanged objectValueOfSelectedItem]];
//    }
//    else if([[WhoChanged identifier] compare: @"ZoneDest"] == NSOrderedSame)
//    {
//        NSLog(@"Changing zone while typing...");
//        Success = [TimeConv setDestZoneWithStr:
//                   [WhoChanged objectValueOfSelectedItem]];
//    }
//}
//
//- (BOOL) control: control textShouldBeginEditing:(NSNotification*) notice
//{
//    return YES;
//}
//
//- (BOOL) control: control textShouldEndEditing: (NSNotification*) notice
//{
//    return FALSE;
//}

- (void) startUpdating
{
    UpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval: 0.2
                                     target: TimeConv
                                   selector: @selector(updateViews)
                                   userInfo: [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"]
                                    repeats: YES];
    NSLog(@"Timer fired.");
}

@end
