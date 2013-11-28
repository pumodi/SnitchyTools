//
//  NSTimerController.h
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimerController : NSObject {
    NSTextField *timerLabel;
    NSTimer *pollingTimer;
    NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) IBOutlet NSTextField *timerLabel;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@end
