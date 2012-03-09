//
//  TimeConverter.h
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeConverter : NSObject

- (void) setSrcToNowByTimer: (NSTimer*) timer;
- (void) setSrcToNow;
- (void) setSrcView: (id) view;

- (void) updateSrcView;
@end
