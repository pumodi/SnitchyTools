//
//  Snitchkeeper.m
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import "Snitchkeeper.h"

@implementation Snitchkeeper
@synthesize playClock;

int t1ScoreCurrent, t1ScoreOTCurrent, t1ScoreSDCurrent, t2ScoreCurrent, t2ScoreOTCurrent, t2ScoreSDCurrent, t1ScoreWindow, t2ScoreWindow = 0;
BOOL snitchPitchTrue = FALSE;
BOOL clockHasRun, otClockHasRun, sdClockHasRun, seekerClockHasRun, otSeekerClockHasRun, seekerFloorUp, snitchCaughtSD, snitchCaughtOT, snitchCaught, seekerRunning = FALSE;
NSString *gameState = @"";
NSString *teamOneString = @"Team One";
NSString *teamTwoString = @"Team Two";
NSDate *stopDateRegTime, *stopDateOTTime, *stopDateSDTime, * stopDateSeekerFloorTime, *stopDateOTSeekerFloorTime, *snitchHasReturnedDate, *clearanceDate;

// This IBAction method receives user input and updates scores

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

// This IBAction takes user input to delegate state management and play clock management.

- (IBAction)buttonStateManager:(id)sender {
    [self regTimeStateManager];
    [self otStateManager];
    [self sdStateManager];
    if (commitGame.state == NSOnState) {
        [self onCommitGamePressed];
        commitGame.state = NSOffState;
    }
    else {
        [self updateWindowScore];
    }
    [self updateWindowScore];
}

// This IBAction takes user input and signals snitchkeeper that the snitch has returned to the field.

- (IBAction)onSnitchPitchPressed:(id)sender {
    if(!snitchPitchTrue) {
        [snitchPitch setEnabled:NO];
        snitchPitchTrue = YES;
        snitchHasReturnedDate = [NSDate dateWithTimeInterval:0 sinceDate:startDate];
    }
    else {
        snitchPitchTrue = NO;
    }
    
}

// These three functions manage button states in conjuction with the buttonStateManager

- (void)regTimeStateManager {
    if(startGame.state == NSOnState) {
        startGame.state = NSOffState;
        [self onStartPressed];
    }
    else if(stopPlay.state == NSOnState) {
        stopPlay.state = NSOffState;
        [self onStopPressed];
    }
    else if(stopPlaySeekerContinue.state == NSOnState) {
        stopPlaySeekerContinue.state = NSOffState;
        [self onStopContinueSeekerFloorPressed];
    }
    else if (endGame.state == NSOnState) {
        endGame.state = NSOffState;
        [self onEndGamePressed];
    }
}

- (void)otStateManager {
    if (startGameOT.state == NSOnState) {
        startGameOT.state = NSOffState;
        [self onStartGameOTPressed];
    }
    else if(stopPlayOT.state == NSOnState) {
        stopPlayOT.state = NSOffState;
        [self onStopPlayOTPressed];
    }
    else if (endGameOT.state == NSOnState) {
        endGameOT.state = NSOffState;
        [self onEndGameOTPressed];
        [clockWinOverTimeIndic setHidden:YES];
        [commitGame setEnabled:YES];
    }
}

- (void)sdStateManager {
    if (startGameSD.state == NSOnState) {
        [self onStartGameSDPressed];
        startGameSD.state = NSOffState;
    }
    else if (stopPlaySD.state == NSOnState) {
        [self onStopPlaySDPressed];
        stopPlaySD.state = NSOffState;
    }
    else if (endGameSD.state == NSOnState) {
        [self onEndGameSDPressed];
        endGameSD.state = NSOffState;
    }
}

// These five methods provide NSTimers for the updateTimer functions

- (void)startPlayClock {
    if (!clockHasRun) {
        clockHasRun = TRUE;
        startDate = [NSDate date];
    }
    else {
        startDate = stopDateRegTime;
    }
    playClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                 target:self
                                                selector:@selector(updateTimerRegTime:)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)startOTClock {
    if (!otClockHasRun) {
        otClockHasRun = TRUE;
        otDate = [NSDate date];
    }
    else {
        otDate = stopDateOTTime;
    }
    
    otClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                      target:self
                                                  selector:@selector(updateTimerOTTime:)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)startSDClock {
    if (!sdClockHasRun) {
        sdDate = [NSDate date];
        sdClockHasRun = TRUE;
    }
    else {
        sdDate = stopDateSDTime;
    }
    
    sdClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                    target:self
                                                  selector:@selector(updateTimerSDTime:)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)startSeekerFloor {
    if (!seekerClockHasRun) {
        seekerClockHasRun = TRUE;
        seekerDate = [NSDate date];
    }
    else {
        seekerDate = stopDateSeekerFloorTime;
    }
    
    seekerFloorTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(updateTimerSeekerFloor:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)startOTSeekerFloor {
    if (!otSeekerClockHasRun) {
        otSeekerDate = [NSDate date];
        otSeekerClockHasRun = TRUE;
    }
    else {
        otSeekerDate = stopDateOTSeekerFloorTime;
    }
    
    otSeekerFloorTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                        selector:@selector(updateTimerOTSeekerFloor:)
                                                      userInfo:nil
                                                       repeats:YES];
}

// These five functions invalidate (stop) play clocks and store the time as a variable to resume them later on

- (void)playClockPause {
    stopDateRegTime = [NSDate dateWithTimeInterval:0 sinceDate:startDate];
    [playClockTimer invalidate];
}

- (void)otClockPause {
    stopDateOTTime = [NSDate dateWithTimeInterval:0 sinceDate:otDate];
    [otClockTimer invalidate];
}

- (void)sdClockPause {
    stopDateSDTime = [NSDate dateWithTimeInterval:0 sinceDate:sdDate];
    [sdClockTimer invalidate];
}

- (void)seekerClockPause {
    stopDateSeekerFloorTime = [NSDate dateWithTimeInterval:0 sinceDate:seekerDate];
    [seekerFloorTimer invalidate];
}

- (void)otSeekerClockPause {
    stopDateOTSeekerFloorTime = [NSDate dateWithTimeInterval:0 sinceDate:otSeekerDate];
    [otSeekerFloorTimer invalidate];
}

- (void)pauseAllClocks {
    [self playClockPause];
    [self otClockPause];
    [self sdClockPause];
    [self seekerClockPause];
    [self otSeekerClockPause];
}

// These five methods provide an interface for the timers and their associated NSTextFields

- (void)updateTimerRegTime:(NSTimer *)playClockTimer {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerRegDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerRegDate];
    clockWinPlayClock.stringValue = timeString;
    playClock.stringValue = timeString;
}

- (void)updateTimerOTTime:(NSTimer *)otClockTimer {
    NSDate *referenceTime = [NSDate date];
    NSDate *startTime = [NSDate dateWithString:(NSString *)@"0000-00-00 00:05:00 +0000"];
    NSTimeInterval timeInterval = [referenceTime timeIntervalSinceDate:otDate];
    NSDate *currentTime = [NSDate dateWithTimeInterval:-timeInterval sinceDate:startTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-0.0]];
    NSString *timeString = [dateFormatter stringFromDate:currentTime];
    clockWinPlayClock.stringValue = timeString;
    otClock.stringValue = timeString;
}

- (void)updateTimerSDTime:(NSTimer *)sdClockTimer {
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

- (void)updateTimerSeekerFloor:(NSTimer *)seekerFloorTimer {
    NSDate *referenceTime = [NSDate date];
    NSDate *startTime = [NSDate dateWithString:(NSString *)@"0000-00-00 00:10:01 +0000"];
    NSTimeInterval timeInterval = [referenceTime timeIntervalSinceDate:seekerDate];
    NSDate *currentTime = [NSDate dateWithTimeInterval:-timeInterval sinceDate:startTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-0.0]];
    NSString *timeString = [dateFormatter stringFromDate:currentTime];
    clockWinSeekerFloor.stringValue = timeString;
    seekerFloor.stringValue = timeString;
}

- (void)updateTimerOTSeekerFloor:(NSTimer *)otSeekerFloorTimer {
    NSDate *referenceTime = [NSDate date];
    NSDate *startTime = [NSDate dateWithString:(NSString *)@"0000-00-00 00:00:30 +0000"];
    NSTimeInterval timeInterval = [referenceTime timeIntervalSinceDate:otSeekerDate];
    NSDate *currentTime = [NSDate dateWithTimeInterval:-timeInterval sinceDate:startTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-0.0]];
    NSString *timeString = [dateFormatter stringFromDate:currentTime];
    clockWinSeekerFloor.stringValue = timeString;
    otSeekerFloor.stringValue = timeString;
}


// These three functions handle pushing scores/team names to Window Title & Spectator

- (void)scoreFieldsUpdate {
    if ([gameState  isEqual: @"regTime"]) {
        if (t1ScoreCurrent != 0) {
            [t1Score setIntegerValue:t1ScoreCurrent];
            [clockWinT1Score setIntegerValue:t1ScoreCurrent];
        }
        else if (t1ScoreCurrent == 0) {
            [t1Score setStringValue:@"00"];
            [clockWinT1Score setStringValue:@"00"];
        }
        if (t2ScoreCurrent != 0) {
            [t2Score setIntegerValue:t2ScoreCurrent];
            [clockWinT2Score setIntegerValue:t2ScoreCurrent];
        }
        else if (t2ScoreCurrent == 0) {
            [t2Score setStringValue:@"00"];
            [clockWinT2Score setStringValue:@"00"];
        }
    }
    else if ([gameState  isEqual: @"oTime"]) {
        if (t1ScoreOTCurrent != 0) {
            [t1OTScore setIntegerValue:t1ScoreOTCurrent];
            [clockWinT1Score setIntegerValue:t1ScoreOTCurrent];
        }
        else if (t1ScoreCurrent == 0) {
            [t1OTScore setStringValue:@"00"];
            [clockWinT1Score setStringValue:@"00"];
        }
        if (t2ScoreOTCurrent != 0) {
            [t2OTScore setIntegerValue:t2ScoreOTCurrent];
            [clockWinT2Score setIntegerValue:t2ScoreOTCurrent];
        }
        else if (t2ScoreOTCurrent == 0) {
            [t2OTScore setStringValue:@"00"];
            [clockWinT2Score setStringValue:@"00"];
        }
    }
    else if ([gameState isEqual: @"sdTime"]) {
        if (t1ScoreSDCurrent != 0) {
            [t1SDScore setIntegerValue:t1ScoreSDCurrent];
            [clockWinT1Score setIntegerValue:t1ScoreSDCurrent];
        }
        else if (t1ScoreSDCurrent == 0) {
            [t1SDScore setStringValue:@"00"];
            [clockWinT1Score setStringValue:@"00"];
        }
        if (t2ScoreSDCurrent != 0) {
            [t2SDScore setIntegerValue:t2ScoreSDCurrent];
            [clockWinT2Score setIntegerValue:t2ScoreSDCurrent];
        }
        else if (t2ScoreSDCurrent == 0) {
            [t2SDScore setStringValue:@"00"];
            [clockWinT2Score setStringValue:@"00"];
        }
    }
}

- (void)updateTeams:(id)sender {
    if ([teamOne.selectedItem.title isEqualTo:@"Add Team"]) {
        teamOneString = teamOneTextField.stringValue;
        teamTwoString = teamTwoTextField.stringValue;
    }
    else {
        teamOneString = teamOne.selectedItem.title;
        teamTwoString = teamTwo.selectedItem.title;
    }
    t1Name.stringValue = teamOneString;
    t2Name.stringValue = teamTwoString;
}

- (void)updateWindowScore {
    if ([teamOne.selectedItem.title isEqualTo:@"Add Team"]) {
        teamOneString = teamOneTextField.stringValue;
        teamTwoString = teamTwoTextField.stringValue;
    }
    else {
        teamOneString = teamOne.selectedItem.title;
        teamTwoString = teamTwo.selectedItem.title;
    }
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
    if (((snitchCatchT2.state == NSOnState && ([gameState isEqual:@"regTime"])) || ((snitchCatchT2OT.state == NSOnState && ([gameState isEqual:@"oTime"])) || (snitchCatchT2SD.state == NSOnState && ([gameState isEqual:@"sdTime"]))))) {
        [windowString appendFormat:@" (*%@", scoreWindowb];
    }
    else {
        [windowString appendFormat:@" (%@", scoreWindowb];
    }
    [windowString appendString:@") "];
    snitchKeeper.title = windowString;
    spectator.title = windowString;
    clockWinT1.stringValue = teamOneString;
    clockWinT2.stringValue = teamTwoString;
}

// These four functions disable groups of buttons depending on game state

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

// These 11 methods tell Snitchkeeper what to do when play clock control buttons are pressed. (One method per button)

// Regular Time

- (void)onStartPressed {
    [startGame setEnabled:NO];
    [clockWinRegTimeIndic setHidden:NO];
    [stopPlay setEnabled:YES];
    [stopPlaySeekerContinue setEnabled:YES];
    [endGame setEnabled:YES];
    [addGoalT1 setEnabled:YES];
    [addGoalT2 setEnabled:YES];
    [remGoalT2 setEnabled:YES];
    [remGoalT1 setEnabled:YES];
    [snitchCatchT1 setEnabled:YES];
    [snitchCatchT2 setEnabled:YES];
    [penalty setEnabled:YES];
    if (!clockHasRun) {
        gameState = @"regTime";
        t1Score.stringValue = [NSString stringWithFormat:(NSString *)@"00"];
        t2Score.stringValue = [NSString stringWithFormat:(NSString *)@"00"];
        [clockWinT1Score setIntegerValue:00];
        [clockWinT2Score setIntegerValue:00];
    }
    if (snitchPitchTrue) {
        [snitchPitch setEnabled:NO];
    }
    else {
        [snitchPitch setEnabled:YES];
    }
    [self startPlayClock];
    if (!seekerRunning) {
        [self startSeekerFloor];
        seekerRunning = TRUE;
    }
    else {
        seekerRunning = TRUE;
    }
    [self otDisabled];
    [self sdDisabled];
    [self teamSelectDisabled];
}

- (void)onStopPressed {
    [startGame setEnabled:YES];
    [stopPlay setEnabled:NO];
    [stopPlaySeekerContinue setEnabled:NO];
    [snitchPitch setEnabled:NO];
    [endGame setEnabled:YES];
    [self otDisabled];
    [self sdDisabled];
    [self playClockPause];
    [self seekerClockPause];
    seekerRunning = FALSE;
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
    [self playClockPause];
}

- (void)onEndGamePressed {
    // Stops clock, enables OT buttons
    [startGame setEnabled:YES];
    [stopPlay setEnabled:NO];
    [stopPlaySeekerContinue setEnabled:NO];
    [snitchPitch setEnabled:NO];
    [endGame setEnabled:NO];
    [startGameOT setEnabled:YES];
    [clockWinRegTimeIndic setHidden:YES];
    [commitGame setEnabled:YES];
    [self sdDisabled];
    [self seekerClockPause];
    [self playClockPause];
    seekerRunning = FALSE;
}

// OT

- (void)onStartGameOTPressed {
    [startGameOT setEnabled:NO];
    [clockWinOverTimeIndic setHidden:NO];
    [stopPlayOT setEnabled:YES];
    [endGameOT setEnabled:YES];
    [addGoalT1OT setEnabled:YES];
    [addGoalT2OT setEnabled:YES];
    [remGoalT2OT setEnabled:YES];
    [remGoalT1OT setEnabled:YES];
    [snitchCatchT1OT setEnabled:YES];
    [snitchCatchT2OT setEnabled:YES];
    if (!otClockHasRun) {
        gameState = @"oTime";
        [self regDisabled];
        [self sdDisabled];
        [clockWinT1Score setIntegerValue:00];
        [clockWinT2Score setIntegerValue:00];
        t1OTScore.stringValue = [NSString stringWithFormat:(NSString *)@"00"];
        t2OTScore.stringValue = [NSString stringWithFormat:(NSString *)@"00"];
    }
    [self startOTClock];
    if (!seekerRunning) {
        [self startOTSeekerFloor];
        seekerRunning = TRUE;
    }
    else {
        seekerRunning = TRUE;
    }
    [self regDisabled];
    [self sdDisabled];
}

- (void)onStopPlayOTPressed {
    // Stops clock, enables SD buttons
    [startGameOT setEnabled:YES];
    [stopPlayOT setEnabled:NO];
    [endGameOT setEnabled:YES];
    [self regDisabled];
    [self sdDisabled];
    [self otClockPause];
    [self otSeekerClockPause];
    seekerRunning = FALSE;
}

- (void)onEndGameOTPressed {
    // Stops clock, enables SD buttons
    [startGameOT setEnabled:YES];
    [startGameSD setEnabled:YES];
    [stopPlayOT setEnabled:NO];
    [endGameOT setEnabled:NO];
    [self regDisabled];
    [self otClockPause];
    [self otSeekerClockPause];
    seekerRunning = FALSE;
}

// Sudden Death

- (void)onStartGameSDPressed {
    [startGameSD setEnabled:NO];
    [stopPlaySD setEnabled:YES];
    [endGameSD setEnabled:YES];
    [addGoalT1SD setEnabled:YES];
    [addGoalT2SD setEnabled:YES];
    [remGoalT2SD setEnabled:YES];
    [remGoalT1SD setEnabled:YES];
    [snitchCatchT1SD setEnabled:YES];
    [snitchCatchT2SD setEnabled:YES];
    [clockWinSeekerFloor setHidden:YES];
    [clockWinSeekerFloorTitle setHidden:YES];
    [clockWinSDTimeIndic setHidden:NO];
    if (!sdClockHasRun) {
        gameState = @"sdTime";
        [self regDisabled];
        [self otDisabled];
        [clockWinT1Score setIntegerValue:00];
        [clockWinT2Score setIntegerValue:00];
        t1SDScore.stringValue = [NSString stringWithFormat:(NSString *)@"00"];
        t2SDScore.stringValue = [NSString stringWithFormat:(NSString *)@"00"];
    }
    [self startSDClock];
}

- (void)onStopPlaySDPressed {
    [startGameSD setEnabled:YES];
    [stopPlaySD setEnabled:NO];
    [endGameSD setEnabled:YES];
    [self regDisabled];
    [self otDisabled];
    [self sdClockPause];
}

- (void)onEndGameSDPressed {
    [startGameSD setEnabled:YES];
    [stopPlaySD setEnabled:NO];
    [endGameSD setEnabled:NO];
    [commitGame setEnabled:YES];
    [clockWinSDTimeIndic setHidden:YES];
    [self regDisabled];
    [self otDisabled];
    [self sdClockPause];
}

// Commit

- (void)onCommitGamePressed {
    [self regDisabled];
    [self otDisabled];
    [self sdDisabled];
    [self pauseAllClocks];
    [commitGame setEnabled:NO];
}

- (IBAction)updateIP:(id)sender {
    makeKeyAndOrderFront:(penaltyWindow);
    [_ipTeamSelector setLabel:teamOneString forSegment:0];
    [_ipTeamSelector setLabel:teamTwoString forSegment:1];
    if ([gameState isEqualToString:@"regTime"]) {
        _ipClockTime.stringValue = playClock.stringValue;
    }
    else if ([gameState isEqualToString:@"otTime"]) {
        _ipClockTime.stringValue = otClock.stringValue;
    }
    else if ([gameState isEqualToString:@"sdTime"]) {
        _ipClockTime.stringValue = sdClock.stringValue;
    }
}

@end