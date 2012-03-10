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
    // Some constants
    NSArray* ZoneNames;
    NSArray* ZoneNamesShort;
    NSTimeZone* LocalZone;

    NSTimeZone* ZoneSrc;
    NSTimeZone* ZoneDest;
    bool ZoneSrcShort;
    bool ZoneDestShort;
    
    NSTimer* UpdateTimer;
    
    id SrcTimeView;
    id SrcZoneView;
    id DestTimeView;
    id DestZoneView;
    // NSDatePicker* DestTimeView;
    
    NSDate* LastTimeSrc;
    NSDate* LastTimeDest;
}

@synthesize Time;

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialize self.
        ZoneNames = [NSTimeZone knownTimeZoneNames];
        ZoneNamesShort = [[NSTimeZone abbreviationDictionary] allKeys];  
        LocalZone = [NSTimeZone localTimeZone];
        
        Time = [NSDate date];
        NSLog(@"Time converter initialized.");
    }
    return self;
}

- (void) setTimeToNowByTimer: (NSTimer*) timer
{
    NSLog(@"Timer %@ requests to update src time.", timer);
    [self setTimeToNow];
    [self updateTimeSrcView];
}

- (void) setTimeToNow
{
    Time = [NSDate date];
}


- (void) setSrcView: (id) src_view srcZoneView: (id) src_zone_view
{
    SrcTimeView = src_view;
    SrcZoneView = src_zone_view;
    [SrcTimeView setDateValue: Time];
}

- (void) setDestView: (id) dest_view destZoneView: (id) dest_zone_view
{
    DestTimeView = dest_view;
    DestZoneView = dest_zone_view;
    [DestTimeView setDateValue: Time];
}

- (void) genSrcZoneViewList: (bool) shortp
{
    [SrcZoneView removeAllItems];
    
    if(shortp)
    {
        NSArray* Zones = ZoneNamesShort;
        [SrcZoneView addItemsWithObjectValues: Zones];
        ZoneSrcShort = true;
    }
    else
    {
        NSArray* Zones = ZoneNames;
        [SrcZoneView addItemsWithObjectValues: Zones];
        ZoneSrcShort = false;
    }
    [self setSrcZoneWithZone: ZoneSrc];
}

- (void) genDestZoneViewList: (bool) shortp
{
    [DestZoneView removeAllItems];
    
    if(shortp)
    {
        NSArray* Zones = ZoneNamesShort;
        [DestZoneView addItemsWithObjectValues: Zones];
        ZoneDestShort = true;
    }
    else
    {
        NSArray* Zones = ZoneNames;
        [DestZoneView addItemsWithObjectValues: Zones];
        ZoneDestShort = false;
    }
    [self setDestZoneWithZone: ZoneDest];
}

- (void) setSrcZoneWithZone: (NSTimeZone*) zone
{
    ZoneSrc = zone;
    [SrcTimeView setTimeZone: ZoneSrc];
    [self updateZoneSrcView];
}

- (void) setDestZoneWithZone: (NSTimeZone*) zone
{
    ZoneDest = zone;
    [DestTimeView setTimeZone: ZoneDest];
    [self updateZoneDestView];
}

- (bool) setSrcZoneWithStr: (NSString*) zone
{
    NSLog(@"Trying to set src zone to %@", zone);

    if(!zone)
    {
        ZoneSrc = nil;
        return false;
    }
    
    NSTimeZone* Zone = [NSTimeZone timeZoneWithAbbreviation: zone];
    if(!Zone)
    {
        Zone = [NSTimeZone timeZoneWithName: zone];
        if(!Zone)
        {
            ZoneSrc = nil;
            return false;
        }
    }
    
    [self setSrcZoneWithZone: Zone];
    return true;
}

- (bool) setDestZoneWithStr: (NSString*) zone
{
    NSLog(@"Trying to set dest zone to %@", zone);
    
    if(!zone)
    {
        ZoneDest = nil;
        return false;
    }
    NSTimeZone* Zone = [NSTimeZone timeZoneWithAbbreviation: zone];
    if(!Zone)
    {
        Zone = [NSTimeZone timeZoneWithName: zone];
        if(!Zone)
        {
            ZoneDest = nil;
            return false;
        }
    }
    
    [self setDestZoneWithZone: Zone];
    return true;
}

- (void) setSrcZoneToLocal
{
    [self setSrcZoneWithZone: LocalZone];
}

- (void) setDestZoneToLocal
{
    [self setDestZoneWithZone: LocalZone];
}

- (void) updateTimeSrcView
{
    [SrcTimeView setDateValue: Time];
}

- (void) updateTimeDestView
{
    [DestTimeView setDateValue: Time];
}

- (void) updateZoneSrcView
{
    if(!ZoneSrc)
        return;
    
    if(ZoneSrcShort)
    {
        [SrcZoneView selectItemWithObjectValue: [ZoneSrc abbreviation]];
    }
    else
    {
        [SrcZoneView selectItemWithObjectValue: [ZoneSrc name]];
    }
}
- (void) updateZoneDestView
{
    if(!ZoneDest)
        return;
    
    if(ZoneDestShort)
    {
        [DestZoneView selectItemWithObjectValue: [ZoneDest abbreviation]];
    }
    else
    {
        [DestZoneView selectItemWithObjectValue: [ZoneDest name]];
    }
}

- (void) updateViews
{
    NSDate* TimeSrc = [SrcTimeView dateValue];
    NSDate* TimeDest = [DestTimeView dateValue];
    if([TimeSrc isEqualToDate: TimeDest])
    {
        Time = TimeSrc;
        NSLog(@"Time set according to both views.");
        return;
    }
    
    if([TimeSrc isEqualToDate: Time])
    {// TimeDest changed
        Time = TimeDest;
        [self updateTimeSrcView];
        NSLog(@"Time set according to dest time.");
        return;
    }
    
    if([TimeDest isEqualToDate: Time])
    { // TimeSrc changed
        Time = TimeSrc;
        [self updateTimeDestView];
        NSLog(@"Time set according to src time.");
        return;
    }
    
    [self updateTimeSrcView];
    [self updateTimeDestView];
    NSLog(@"Time not changed.");
    return;
}

- (void) startUpdating
{
    UpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval: 0.2
                                     target: self
                                   selector: @selector(updateViews)
                                   userInfo: [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"]
                                    repeats: YES];
    NSLog(@"Timer fired.");
}

@end
