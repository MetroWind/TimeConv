//
//  TimeConverter.h
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeConverter : NSObject
@property (strong) NSDate* TimeSrc;
@property (strong) NSDate* TimeDest;

- (void) setSrcView: (id) view srcZoneView: (id) view;
- (void) setDestView: (id) view destZoneView: (id) view;

- (void) genSrcZoneViewList: (bool) shortp;
- (void) genDestZoneViewList: (bool) shortp;

- (void) setSrcZoneWithZone: (NSTimeZone*) zone;
- (void) setDestZoneWithZone: (NSTimeZone*) zone;
- (bool) setSrcZoneWithStr: (NSString*) zone;
- (bool) setDestZoneWithStr: (NSString*) zone;
- (void) setSrcZoneToLocal;
- (void) setDestZoneToLocal;

- (void) updateTimeSrcView;
- (void) updateTimeDestView;
- (void) updateZoneSrcView;
- (void) updateZoneDestView;

- (void) updateViews;

- (NSDate*) convertTime: (NSDate*) time fromZone: (NSTimeZone*) zone_src
                 toZone: (NSTimeZone*) zone_dest;
@end
