//
//  AppDelegate.h
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSDatePicker *SrcTimeView;
@property (weak) IBOutlet NSComboBox *SrcTimeZoneView;
@property (weak) IBOutlet NSButton *BtnSrcZoneShort;
@property (weak) IBOutlet NSDatePicker *DestTimeView;
@property (weak) IBOutlet NSComboBox *DestTimeZoneView;
@property (weak) IBOutlet NSButton *BtnDestZoneShort;
@property (weak) IBOutlet NSImageView *Seperator;

- (IBAction)onBtnSrcZoneShortClick:(id)sender;
- (IBAction)onBtnDestZoneShortClick:(id)sender;
- (IBAction)onZoneSrcChange:(id)sender;
- (IBAction)onZoneDestChange:(id)sender;

@end
