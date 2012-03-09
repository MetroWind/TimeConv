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
- (void) startUpdatingCurrentTime;
- (void) stopUpdatingCurrentTime;
@end
