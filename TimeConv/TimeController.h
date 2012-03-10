//
//  TimeController.h
//  TimeConv
//
//  Created by Corsair Sun on 3/9/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeController : NSObject

- (void) setConverter: (id) converter;
- (void) setSrcView: (id) view srcZoneView: (id) view;
- (void) setDestView: (id) view destZoneView: (id) view;

- (void) shortSrcZone: (bool) shortp;
- (void) shortDestZone: (bool) shortp;

@end
