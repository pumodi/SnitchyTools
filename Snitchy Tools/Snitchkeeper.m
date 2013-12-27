//
//  Snitchkeeper.m
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import "Snitchkeeper.h"
#import "NSTimerController.h"

@implementation Snitchkeeper
@synthesize playClock;

BOOL snitchPitchTrue = FALSE;
int currentTime = 0;
int hours, minutes, seconds = 0;
int t1ScoreCurrent, t1ScoreOTCurrent, t1ScoreSDCurrent, t2ScoreCurrent, t2ScoreOTCurrent, t2ScoreSDCurrent = 0;
int t1ScoreWindow = 0;
int t2ScoreWindow = 0;
BOOL snitchCaught = FALSE;
BOOL snitchCaughtOT = FALSE;
BOOL snitchCaughtSD = FALSE;
NSString *gameState = @"";

- (void)startPlayClock {
    startDate = [NSDate date];
    
    playClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                 target:self
                                               selector:@selector(updateTimerRegTime)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)startOTClock {
    otDate = [NSDate date];
    
    otClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                      target:self
                                                    selector:@selector(updateTimerOTTime)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)startSDClock {
    sdDate = [NSDate date];
    
    sdClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                    target:self
                                                  selector:@selector(updateTimerSDTime)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)startSeekerFloor {
    seekerDate = [NSDate date];
    
    seekerFloorTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(updateTimerSeekerFloor)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)updateTimerRegTime {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    clockWinPlayClock.stringValue = timeString;
    playClock.stringValue = timeString;
}

- (void)updateTimerOTTime {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:otDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    clockWinPlayClock.stringValue = timeString;
    otClock.stringValue = timeString;
}

- (void)updateTimerSDTime {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:sdDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    clockWinPlayClock.stringValue = timeString;
    sdClock.stringValue = timeString;
}

- (void)updateTimerSeekerFloor {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:seekerDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    clockWinPlayClock.stringValue = timeString;
    clockWinSeekerFloor.stringValue = timeString;
    seekerFloor.stringValue = timeString;
}

- (IBAction)scoreManager:(id)sender {
    if ([gameState isEqual: @"regTime"]) {
        if (addGoalT1.state == NSOnState) {
            t1ScoreCurrent = t1ScoreCurrent + 10;
            addGoalT1.state = NSOffState;
        }
        else if (addGoalT2.state == NSOnState) {
            t2ScoreCurrent = t2ScoreCurrent + 10;
            addGoalT2.state = NSOffState;
        }
        else if (remGoalT1.state == NSOnState) {
            if (t1ScoreCurrent > 1) {
                t1ScoreCurrent = t1ScoreCurrent - 10;
            }
            remGoalT1.state = NSOffState;
        }
        else if (remGoalT2.state == NSOnState) {
            if (t2ScoreCurrent > 1) {
                t2ScoreCurrent = t2ScoreCurrent - 10;
            }
            remGoalT2.state = NSOffState;
        }
        else if (snitchCatchT1.state == NSOnState && !snitchCaught) {
            t1ScoreCurrent = t1ScoreCurrent + 30;
            [snitchCatchT2 setEnabled:NO];
            snitchCaught = TRUE;
        }
        else if (snitchCatchT2.state == NSOnState && !snitchCaught) {
            t2ScoreCurrent = t2ScoreCurrent + 30;
            [snitchCatchT1 setEnabled:NO];
            snitchCaught = TRUE;
        }
        else if (snitchCatchT1.state == NSOffState && snitchCaught && t1ScoreCurrent > 1) {
            t1ScoreCurrent = t1ScoreCurrent - 30;
            [snitchCatchT2 setEnabled:YES];
            snitchCaught = FALSE;
        }
        else if (snitchCatchT2.state == NSOffState && snitchCaught && t2ScoreCurrent > 1) {
            t2ScoreCurrent = t2ScoreCurrent - 30;
            [snitchCatchT1 setEnabled:YES];
            snitchCaught = FALSE;
        }
    }
    else if ([gameState isEqual: @"oTime"]) {
        if (addGoalT1OT.state == NSOnState) {
            t1ScoreOTCurrent = t1ScoreOTCurrent + 10;
            addGoalT1OT.state = NSOffState;
        }
        else if (addGoalT2OT.state == NSOnState) {
            t2ScoreOTCurrent = t2ScoreOTCurrent + 10;
            addGoalT2OT.state = NSOffState;
        }
        else if (remGoalT1OT.state == NSOnState) {
            if (t1ScoreOTCurrent > 1) {
                t1ScoreOTCurrent = t1ScoreOTCurrent - 10;
            }
            remGoalT1OT.state = NSOffState;
        }
        else if (remGoalT2OT.state == NSOnState) {
            if (t2ScoreOTCurrent > 1) {
                t2ScoreOTCurrent = t2ScoreOTCurrent - 10;
            }
            remGoalT2OT.state = NSOffState;
        }
        else if (snitchCatchT1OT.state == NSOnState && !snitchCaughtOT) {
            t1ScoreOTCurrent = t1ScoreOTCurrent + 30;
            [snitchCatchT2OT setEnabled:NO];
            snitchCaughtOT = TRUE;
        }
        else if (snitchCatchT2OT.state == NSOnState && !snitchCaughtOT) {
            t2ScoreOTCurrent = t2ScoreOTCurrent + 30;
            [snitchCatchT1OT setEnabled:NO];
            snitchCaughtOT = TRUE;
        }
        else if (snitchCatchT1OT.state == NSOffState && snitchCaughtOT && t1ScoreOTCurrent > 1) {
            t1ScoreOTCurrent = t1ScoreOTCurrent - 30;
            [snitchCatchT2OT setEnabled:YES];
            snitchCaughtOT = FALSE;
        }
        else if (snitchCatchT2OT.state == NSOffState && snitchCaughtOT && t2ScoreOTCurrent > 1) {
            t2ScoreCurrent = t2ScoreCurrent - 30;
            [snitchCatchT1OT setEnabled:YES];
            snitchCaughtOT = FALSE;
        }
    }
    else if ([gameState isEqual: @"sdTime"]) {
        if (addGoalT1SD.state == NSOnState) {
            t1ScoreSDCurrent = t1ScoreSDCurrent + 10;
            addGoalT1SD.state = NSOffState;
        }
        else if (addGoalT2SD.state == NSOnState) {
            t2ScoreSDCurrent = t2ScoreSDCurrent + 10;
            addGoalT2SD.state = NSOffState;
        }
        else if (remGoalT1SD.state == NSOnState) {
            if (t1ScoreSDCurrent > 1) {
                t1ScoreSDCurrent = t1ScoreSDCurrent - 10;
            }
            remGoalT1SD.state = NSOffState;
        }
        else if (remGoalT2SD.state == NSOnState) {
            if (t2ScoreSDCurrent > 1) {
                t2ScoreSDCurrent = t2ScoreSDCurrent - 10;
            }
            remGoalT2SD.state = NSOffState;
        }
        else if (snitchCatchT1SD.state == NSOnState && !snitchCaughtSD) {
            t1ScoreSDCurrent = t1ScoreSDCurrent + 30;
            [snitchCatchT2SD setEnabled:NO];
            snitchCaughtSD = TRUE;
        }
        else if (snitchCatchT2SD.state == NSOnState && !snitchCaughtSD) {
            t2ScoreSDCurrent = t2ScoreSDCurrent + 30;
            [snitchCatchT1SD setEnabled:NO];
            snitchCaughtSD = TRUE;
        }
        else if (snitchCatchT1SD.state == NSOffState && snitchCaughtSD && t1ScoreSDCurrent > 1) {
            t1ScoreSDCurrent = t1ScoreSDCurrent - 30;
            [snitchCatchT2SD setEnabled:YES];
            snitchCaughtSD = FALSE;
        }
        else if (snitchCatchT2SD.state == NSOffState && snitchCaughtSD && t2ScoreSDCurrent > 1) {
            t2ScoreSDCurrent = t2ScoreSDCurrent - 30;
            [snitchCatchT1SD setEnabled:YES];
            snitchCaughtSD = FALSE;
        }
    }
    [self scoreFieldsUpdate];
    [self updateWindowScore];
}

- (IBAction)buttonStateManager:(id)sender {
    if(startGame.state == NSOnState) {
        [self onStartPressed];
        startGame.state = NSOffState;
        [clockWinRegTimeIndic setHidden:NO];
    }
    else if(stopPlay.state == NSOnState) {
        [self onStopPressed];
        stopPlay.state = NSOffState;
    }
    else if(stopPlaySeekerContinue.state == NSOnState) {
        [self onStopContinueSeekerFloorPressed];
        stopPlaySeekerContinue.state = NSOffState;
    }
    else if (endGame.state == NSOnState) {
        [self onEndGamePressed];
        endGame.state = NSOffState;
        [clockWinRegTimeIndic setHidden:YES];
    }
    else if (startGameOT.state == NSOnState) {
        [self onStartGameOTPressed];
        startGameOT.state = NSOffState;
        [clockWinT1Score setIntegerValue:00];
        [clockWinT2Score setIntegerValue:00];
        [clockWinOverTimeIndic setHidden:NO];
    }
    else if(stopPlayOT.state == NSOnState) {
        [self onStopPlayOTPressed];
        stopPlayOT.state = NSOffState;
    }
    else if (endGameOT.state == NSOnState) {
        [self onEndGameOTPressed];
        endGameOT.state = NSOffState;
        [clockWinOverTimeIndic setHidden:YES];
    }
    else if (startGameSD.state == NSOnState) {
        [self onStartGameSDPressed];
        startGameSD.state = NSOffState;
        [clockWinT1Score setIntegerValue:00];
        [clockWinT2Score setIntegerValue:00];
        [clockWinSDTimeIndic setHidden:NO];
    }
    else if (stopPlaySD.state == NSOnState) {
        [self onStopPlaySDPressed];
        stopPlaySD.state = NSOffState;
    }
    else if (endGameSD.state == NSOnState) {
        [self onEndGameSDPressed];
        endGameSD.state = NSOffState;
        [clockWinSDTimeIndic setHidden:YES];
    }
    else if (commitGame.state == NSOnState) {
        [self onCommitGamePressed];
        commitGame.state = NSOffState;
    }
    else {
        [self updateWindowScore];
    }
    [self updateWindowScore];
}

- (IBAction)onSnitchPitchPressed:(id)sender {
    if(!snitchPitchTrue) {
        [snitchPitch setEnabled:NO];
        snitchPitchTrue = YES;
    }
    else {
        snitchPitchTrue = NO;
    }
    
}

- (void)scoreFieldsUpdate {
    if ([gameState  isEqual: @"regTime"]) {
        [t1Score setIntegerValue:t1ScoreCurrent];
        [t2Score setIntegerValue:t2ScoreCurrent];
        [clockWinT1Score setIntegerValue:t1ScoreCurrent];
        [clockWinT2Score setIntegerValue:t2ScoreCurrent];
    }
    else if ([gameState  isEqual: @"oTime"]) {
        [t1OTScore setIntegerValue:t1ScoreOTCurrent];
        [t2OTScore setIntegerValue:t2ScoreOTCurrent];
        [clockWinT1Score setIntegerValue:t1ScoreOTCurrent];
        [clockWinT2Score setIntegerValue:t2ScoreOTCurrent];
    }
    else if ([gameState isEqual: @"sdTime"]) {
        [t1SDScore setIntegerValue:t1ScoreSDCurrent];
        [t2SDScore setIntegerValue:t2ScoreSDCurrent];
        [clockWinT1Score setIntegerValue:t1ScoreSDCurrent];
        [clockWinT2Score setIntegerValue:t2ScoreSDCurrent];
    }
}

- (void)updateTeams:(id)sender {
    NSString *teamOneString = teamOne.selectedItem.title;
    NSString *teamTwoString = teamTwo.selectedItem.title;
    t1Name.stringValue = teamOneString;
    t2Name.stringValue = teamTwoString;
}

- (void)teamSelectDisabled {
    [snitch setEnabled:NO];
    [teamOne setEnabled:NO];
    [teamTwo setEnabled:NO];
}

- (void)regDisabled {
    [startGame setEnabled:NO];
    [stopPlay setEnabled:NO];
    [stopPlaySeekerContinue setEnabled:NO];
    [endGame setEnabled:NO];
    [snitchPitch setEnabled:NO];
    [addGoalT1 setEnabled:NO];
    [addGoalT2 setEnabled:NO];
    [remGoalT1 setEnabled:NO];
    [remGoalT2 setEnabled:NO];
    [snitchCatchT1 setEnabled:NO];
    [snitchCatchT2 setEnabled:NO];
}

- (void)otDisabled {
    [startGameOT setEnabled:NO];
    [stopPlayOT setEnabled:NO];
    [endGameOT setEnabled:NO];
    [addGoalT1OT setEnabled:NO];
    [addGoalT2OT setEnabled:NO];
    [remGoalT1OT setEnabled:NO];
    [remGoalT2OT setEnabled:NO];
    [snitchCatchT1OT setEnabled:NO];
    [snitchCatchT2OT setEnabled:NO];
}

- (void)sdDisabled {
    [startGameSD setEnabled:NO];
    [stopPlaySD setEnabled:NO];
    [endGameSD setEnabled:NO];
    [addGoalT1SD setEnabled:NO];
    [addGoalT2SD setEnabled:NO];
    [remGoalT1SD setEnabled:NO];
    [remGoalT2SD setEnabled:NO];
    [snitchCatchT1SD setEnabled:NO];
    [snitchCatchT2SD setEnabled:NO];
}

- (void)onStartPressed {
    [startGame setEnabled:NO];
    [stopPlay setEnabled:YES];
    [stopPlaySeekerContinue setEnabled:YES];
    [endGame setEnabled:YES];
    [self otDisabled];
    [self sdDisabled];
    [self teamSelectDisabled];
    gameState = @"regTime";
    [addGoalT1 setEnabled:YES];
    [addGoalT2 setEnabled:YES];
    [remGoalT2 setEnabled:YES];
    [remGoalT1 setEnabled:YES];
    [snitchCatchT1 setEnabled:YES];
    [snitchCatchT2 setEnabled:YES];
    if (snitchPitchTrue) {
        [snitchPitch setEnabled:NO];
    }
    else {
        [snitchPitch setEnabled:YES];
    }
    [self startPlayClock];
    [self startSeekerFloor];
}

- (void)onStopPressed {
    [startGame setEnabled:YES];
    [stopPlay setEnabled:NO];
    [stopPlaySeekerContinue setEnabled:NO];
    [snitchPitch setEnabled:NO];
    [endGame setEnabled:YES];
    [self otDisabled];
    [self sdDisabled];
}

- (void)onStopContinueSeekerFloorPressed {
    // Gameplay clock stops, seeker floor clock continues to count down
    [startGame setEnabled:YES];
    [stopPlay setEnabled:NO];
    [stopPlaySeekerContinue setEnabled:NO];
    [snitchPitch setEnabled:NO];
    [endGame setEnabled:NO];
    [self otDisabled];
    [self sdDisabled];
}

- (void)onEndGamePressed {
    // Stops clock, enables OT buttons
    [startGame setEnabled:YES];
    [stopPlay setEnabled:NO];
    [stopPlaySeekerContinue setEnabled:NO];
    [snitchPitch setEnabled:NO];
    [endGame setEnabled:NO];
    [startGameOT setEnabled:YES];
    [self sdDisabled];
}

- (void)onStartGameOTPressed {
    // Stops clock, enables SD buttons
    [startGameOT setEnabled:NO];
    [stopPlayOT setEnabled:YES];
    [endGameOT setEnabled:YES];
    [self regDisabled];
    [self sdDisabled];
    gameState = @"oTime";
    [addGoalT1OT setEnabled:YES];
    [addGoalT2OT setEnabled:YES];
    [remGoalT2OT setEnabled:YES];
    [remGoalT1OT setEnabled:YES];
    [snitchCatchT1OT setEnabled:YES];
    [snitchCatchT2OT setEnabled:YES];
    [self startOTClock];
}

- (void)onStopPlayOTPressed {
    // Stops clock, enables SD buttons
    [startGameOT setEnabled:YES];
    [stopPlayOT setEnabled:NO];
    [endGameOT setEnabled:YES];
    [self regDisabled];
    [self sdDisabled];
}

- (void)onEndGameOTPressed {
    // Stops clock, enables SD buttons
    [startGameOT setEnabled:YES];
    [startGameSD setEnabled:YES];
    [stopPlayOT setEnabled:NO];
    [endGameOT setEnabled:NO];
    [self regDisabled];
}

- (void)onStartGameSDPressed {
    [startGameSD setEnabled:NO];
    [stopPlaySD setEnabled:YES];
    [endGameSD setEnabled:YES];
    [self regDisabled];
    [self otDisabled];
    gameState = @"sdTime";
    [addGoalT1SD setEnabled:YES];
    [addGoalT2SD setEnabled:YES];
    [remGoalT2SD setEnabled:YES];
    [remGoalT1SD setEnabled:YES];
    [snitchCatchT1SD setEnabled:YES];
    [snitchCatchT2SD setEnabled:YES];
    [self startSDClock];
}

- (void)onStopPlaySDPressed {
    [startGameSD setEnabled:YES];
    [stopPlaySD setEnabled:NO];
    [endGameSD setEnabled:YES];
    [self regDisabled];
    [self otDisabled];
}

- (void)onEndGameSDPressed {
    [startGameSD setEnabled:YES];
    [stopPlaySD setEnabled:NO];
    [endGameSD setEnabled:NO];
    [self regDisabled];
    [self otDisabled];
}

- (void)onCommitGamePressed {
    [self regDisabled];
    [self otDisabled];
    [self sdDisabled];
}

- (void)updateWindowScore {
    NSString *teamOneString = teamOne.selectedItem.title;
    NSString *teamTwoString = teamTwo.selectedItem.title;
    if ([gameState  isEqual: @"regTime"]) {
        t1ScoreWindow = t1ScoreCurrent;
        t2ScoreWindow = t2ScoreCurrent;
    }
    else if ([gameState isEqual: @"oTime"]) {
        t1ScoreWindow = t1ScoreOTCurrent;
        t2ScoreWindow = t2ScoreOTCurrent;
    }
    else if ([gameState isEqual: @"sdTime"]) {
        t1ScoreWindow = t1ScoreSDCurrent;
        t2ScoreWindow = t2ScoreSDCurrent;
    }
    
    NSString *scoreWindowA = [NSString stringWithFormat:@"%d", t1ScoreWindow];
    NSString *scoreWindowb = [NSString stringWithFormat:@"%d", t2ScoreWindow];
    NSMutableString *windowString = [NSMutableString stringWithFormat:@"Snitchkeeper - %@", teamOneString];
    if (((snitchCatchT1.state == NSOnState && ([gameState isEqual:@"regTime"])) || ((snitchCatchT1OT.state == NSOnState && ([gameState isEqual:@"oTime"])) || (snitchCatchT1SD.state == NSOnState && ([gameState isEqual:@"sdTime"]))))) {
        [windowString appendFormat:@" (*%@",scoreWindowA];
    }
    else {
    [windowString appendFormat:@" (%@",scoreWindowA];
    }
    [windowString appendFormat:@") %@", teamTwoString];
    if (((snitchCatchT1.state == NSOnState && ([gameState isEqual:@"regTime"])) || ((snitchCatchT1OT.state == NSOnState && ([gameState isEqual:@"oTime"])) || (snitchCatchT1SD.state == NSOnState && ([gameState isEqual:@"sdTime"]))))) {
    [windowString appendFormat:@" (*%@", scoreWindowb];
    }
    else {
        [windowString appendFormat:@" (%@", scoreWindowb];
    }
    [windowString appendString:@") "];
    snitchKeeper.title = windowString;
    spectator.title = windowString;
}

@end