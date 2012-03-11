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
    id TimeControl;
    id TimeConv;
}

@synthesize window;
@synthesize SrcTimeView;
@synthesize SrcTimeZoneView;
@synthesize BtnSrcZoneShort;
@synthesize DestTimeView;
@synthesize DestTimeZoneView;
@synthesize BtnDestZoneShort;
@synthesize Seperator;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSImage* BGImage = [[NSImage alloc] initWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource: @"bg" ofType: @"png"]];
    NSImage* ImageSep = [[NSImage alloc] initWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource: @"seperator" ofType: @"png"]];

    // Insert code here to initialize your application
    [[window contentView] setWantsLayer:YES];
    [[window contentView] layer].contents = BGImage;
    
    [Seperator setImageScaling: NSScaleProportionally];
    [Seperator setImage: ImageSep];
        
    NSTimeZone* LocalZone = [NSTimeZone localTimeZone];
    [SrcTimeView setTimeZone: LocalZone];
    [DestTimeView setTimeZone: LocalZone];
    
    TimeControl = [[TimeController alloc] init];
    TimeConv = [[TimeConverter alloc] init];
    
    [TimeControl setConverter: TimeConv];
    [TimeConv setSrcView: SrcTimeView srcZoneView: SrcTimeZoneView];
    [TimeConv setDestView: DestTimeView destZoneView: DestTimeZoneView];

    // Build timezone list
    [self onBtnSrcZoneShortClick: self];
    [self onBtnDestZoneShortClick: self];
    
    // [TimeConv setDestZoneViewWithZone: [NSTimeZone localTimeZone]];

    [SrcTimeZoneView setDelegate: TimeControl];
    [DestTimeZoneView setDelegate: TimeControl];
    
    [TimeConv updateTimeSrcView];
    [TimeControl startUpdating];

    NSLog(@"Application initialized.");
}

- (IBAction)onBtnSrcZoneShortClick:(id)sender
{
    if([BtnSrcZoneShort state] == NSOnState)
    {
        [TimeControl shortSrcZone: true];
    }
    else
    {
        [TimeControl shortSrcZone: false];
    }
}

- (IBAction)onBtnDestZoneShortClick:(id)sender
{
    if([BtnDestZoneShort state] == NSOnState)
    {
        [TimeControl shortDestZone: true];
    }
    else
    {
        [TimeControl shortDestZone: false];
    }
}

- (IBAction)onZoneSrcChange:(id)sender
{
    NSLog(@"User is changing src zone...");
    [TimeConv setSrcZoneWithStr:
     [SrcTimeZoneView objectValueOfSelectedItem]];
}

- (IBAction)onZoneDestChange:(id)sender
{
    NSLog(@"User is changing dest zone...");
    [TimeConv setDestZoneWithStr:
     [DestTimeZoneView objectValueOfSelectedItem]];
}
@end
