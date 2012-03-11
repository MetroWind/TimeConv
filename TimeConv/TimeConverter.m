//
//  TimeConverter.m
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

// NSDatePicker always interpret user keyboard input as local time,
// therefore if its time zone is set to be non-local, what user types
// is not what s/he sees.  Consequently, we have to set both date
// pickers to local time.

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
    
    id SrcTimeView;
    id SrcZoneView;
    id DestTimeView;
    id DestZoneView;
    // NSDatePicker* DestTimeView;
    
    NSDate* LastTimeSrc;
    NSDate* LastTimeDest;
    // For debug
    NSDateFormatter* Formatter;
}

@synthesize TimeSrc;
@synthesize TimeDest;

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialize self.
        ZoneNames = [NSTimeZone knownTimeZoneNames];
        ZoneNamesShort = [[NSTimeZone abbreviationDictionary] allKeys];  
        LocalZone = [NSTimeZone localTimeZone];
        ZoneSrc = LocalZone;
        ZoneDest = LocalZone;
        
        NSDate* Time = [NSDate date];
        TimeSrc = Time;
        TimeDest = Time;
    
        Formatter = [[NSDateFormatter alloc] init];
        [Formatter setTimeZone: LocalZone];
        [Formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"Time converter initialized.");
    }
    return self;
}

- (void) setSrcView: (id) src_view srcZoneView: (id) src_zone_view
{
    SrcTimeView = src_view;
    SrcZoneView = src_zone_view;
    [SrcTimeView setDateValue: TimeSrc];
}

- (void) setDestView: (id) dest_view destZoneView: (id) dest_zone_view
{
    DestTimeView = dest_view;
    DestZoneView = dest_zone_view;
    [DestTimeView setDateValue: TimeDest];
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
    NSLog(@"Setting src zone to %@...", zone);

    NSTimeZone* OldZone = ZoneSrc;
    ZoneSrc = zone;
    // [SrcTimeView setTimeZone: ZoneSrc];
    TimeSrc = [self convertTime: TimeSrc fromZone: OldZone
                         toZone:ZoneSrc];
    NSLog(@"Src time changed to %@ because of zone change.",
          [Formatter stringFromDate: TimeSrc]);
    
    [self updateTimeSrcView];
    [self updateZoneSrcView];
}

- (void) setDestZoneWithZone: (NSTimeZone*) zone
{
    NSLog(@"Setting dest zone to %@...", zone);

    NSTimeZone* OldZone = ZoneDest;
    ZoneDest = zone;
    // [DestTimeView setTimeZone: ZoneDest];
    TimeDest = [self convertTime: TimeDest fromZone: OldZone
                         toZone:ZoneDest];

    NSLog(@"Dest time changed to %@ because of zone change.",
          [Formatter stringFromDate: TimeDest]);

    [self updateTimeDestView];
    [self updateZoneDestView];
}

- (bool) setSrcZoneWithStr: (NSString*) zone
{
    NSLog(@"Trying to figure out what zone is %@...", zone);

    if(!zone)
    {
        // ZoneSrc = nil;
        return false;
    }
    
    NSTimeZone* Zone = [NSTimeZone timeZoneWithAbbreviation: zone];
    if(!Zone)
    {
        Zone = [NSTimeZone timeZoneWithName: zone];
        if(!Zone)
        {
            // ZoneSrc = nil;
            return false;
        }
    }
    
    [self setSrcZoneWithZone: Zone];
    return true;
}

- (bool) setDestZoneWithStr: (NSString*) zone
{
    NSLog(@"Trying to figure out what zone is %@...", zone);
    
    if(!zone)
    {
        // ZoneDest = nil;
        return false;
    }
    NSTimeZone* Zone = [NSTimeZone timeZoneWithAbbreviation: zone];
    if(!Zone)
    {
        Zone = [NSTimeZone timeZoneWithName: zone];
        if(!Zone)
        {
            // ZoneDest = nil;
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
    NSLog(@"Syncing src view to %@...",
          [Formatter stringFromDate: TimeSrc]);
    [SrcTimeView setDateValue: TimeSrc];
}

- (void) updateTimeDestView
{
    NSLog(@"Syncing dest view to %@...",
          [Formatter stringFromDate: TimeDest]);
    [DestTimeView setDateValue: TimeDest];
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
    NSDate* TimeSrcNew = [SrcTimeView dateValue];
    NSDate* TimeDestNew = [DestTimeView dateValue];
        
    if([TimeSrcNew isEqualToDate: TimeSrc])
    {
        if([TimeDestNew isEqualToDate: TimeDest])
            return;
        else
        {
            NSLog(@"Dest time changed to %@",
                  [Formatter stringFromDate: TimeDestNew]);
            TimeDest = TimeDestNew;
            TimeSrc = [self convertTime: TimeDest
                               fromZone: ZoneDest
                                 toZone: ZoneSrc];
        }
    }
    else
    {
        if([TimeDestNew isEqualToDate: TimeDest])
        {
            NSLog(@"Src time changed to %@",
                  [Formatter stringFromDate: TimeSrcNew]);
            TimeSrc = TimeSrcNew;
            TimeDest = [self convertTime: TimeSrc
                                fromZone: ZoneSrc 
                                  toZone: ZoneDest];
        }
    }

//    if([TimeSrcNew isEqualToDate: TimeDestNew])
//    {
//        Time = TimeSrcNew;
//        NSLog(@"Time set according to both views.");
//        return;
//    }
//    
//    if([TimeSrcNew isEqualToDate: Time])
//    {// TimeDest changed
//        Time = TimeDestNew;
//        [self updateTimeSrcView];
//        NSLog(@"Time set according to dest time.");
//        return;
//    }
//    
//    if([TimeDestNew isEqualToDate: Time])
//    { // TimeSrc changed
//        Time = TimeSrcNew;
//        [self updateTimeDestView];
//        NSLog(@"Time set according to src time.");
//        return;
//    }
    
    [self updateTimeSrcView];
    [self updateTimeDestView];
    NSLog(@"Time not changed.");
    return;
}

- (NSDate*) convertTime: (NSDate*) time fromZone: (NSTimeZone*) zone_src
                 toZone: (NSTimeZone*) zone_dest
{ // `time' is actually interpreted as local time.
    NSDateFormatter* FormatterWoZone = [[NSDateFormatter alloc] init];
    // We need to get the numbers displayed in date picker
    [FormatterWoZone setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [FormatterWoZone setTimeZone: LocalZone];
    
    NSString* TimeStr = [FormatterWoZone stringFromDate: time];
    NSLog(@"Converting %@ from %@ to %@...",
          TimeStr, zone_src, zone_dest);
    
    // Now we'll see what the user actually means
    [FormatterWoZone setTimeZone: zone_src];
    NSDate* ProperTime = [FormatterWoZone dateFromString: TimeStr];
    NSLog(@"... i.e. local time %@...", 
          [Formatter stringFromDate: ProperTime]);

    // What is the time string for this time in `zone_dest'?
    [FormatterWoZone setTimeZone: zone_dest];
    NSString* TimeStrDest = [FormatterWoZone stringFromDate: ProperTime];
    // Acquire the corresponding NSDate (which points to the wrong time but with the same time string).
    [FormatterWoZone setTimeZone: LocalZone];
    return [FormatterWoZone dateFromString: TimeStrDest];
}

@end
