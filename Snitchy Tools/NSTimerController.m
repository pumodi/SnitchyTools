//
//  NSTimerController.m
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import "NSTimerController.h"

@implementation NSTimerController
@synthesize timerLabel, dateFormatter;

-(void)updateTimer:(id)sender {
    NSDate *today = [[NSDate alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH : mm : ss.S"];
    
    NSString *currentTime = [self.dateFormatter stringFromDate: today];
    self.timerLabel.stringValue = currentTime;
    
    pollingTimer = [NSTimer scheduledTimerWithTimeInterval:.01
                                                    target:self
                                                  selector:@selector(pollTime)
                                                  userInfo:Nil
                                                   repeats:YES];
}

- (void)pollTime
{
    NSDate *today = [[NSDate alloc] init];
    NSString *currentTime = [self.dateFormatter stringFromDate: today];
    self.timerLabel.stringValue = currentTime;
}
    
@end
