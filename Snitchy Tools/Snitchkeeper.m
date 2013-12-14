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
NSString *gameState = @"";
int t1ScoreWindow = 0;
int t2ScoreWindow = 0;

-(IBAction)scoreManager:(id)sender {
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
            if (t1ScoreCurrent < 1) {
            }
            else {
                t1ScoreCurrent = t1ScoreCurrent - 10;
            }
            remGoalT1.state = NSOffState;
        }
        else if (remGoalT2.state == NSOnState) {
            if (t2ScoreCurrent < 1) {
            }
            else {
                t2ScoreCurrent = t2ScoreCurrent - 10;
            }
            remGoalT2.state = NSOffState;
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
            if (t1ScoreOTCurrent < 1) {
            }
            else {
                t1ScoreOTCurrent = t1ScoreOTCurrent - 10;
            }
            remGoalT1OT.state = NSOffState;
        }
        else if (remGoalT2OT.state == NSOnState) {
            if (t2ScoreOTCurrent < 1) {
            }
            else {
                t2ScoreOTCurrent = t2ScoreOTCurrent - 10;
            }
            remGoalT2OT.state = NSOffState;
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
            if (t1ScoreSDCurrent < 1) {
            }
            else {
                t1ScoreSDCurrent = t1ScoreSDCurrent - 10;
            }
            remGoalT1SD.state = NSOffState;
        }
        else if (remGoalT2SD.state == NSOnState) {
            if (t2ScoreSDCurrent < 1) {
            }
            else {
                t2ScoreSDCurrent = t2ScoreSDCurrent - 10;
            }
            remGoalT2SD.state = NSOffState;
        }
    }
    [self scoreFieldsUpdate];
    [self updateWindowScore];
}

-(IBAction)updateSnitchCatch:(id)sender {
    if ([gameState isEqual:@"regTime"]) {
        if (snitchCatchT1.state == NSOnState) {
            t1ScoreCurrent = t1ScoreCurrent + 30;
        }
        else if (snitchCatchT2.state == NSOnState) {
            t2ScoreCurrent = t2ScoreCurrent + 30;
        }
    }
    else if ([gameState isEqual:@"oTime"]) {
        if (snitchCatchT1OT.state == NSOnState) {
            t1ScoreOTCurrent = t1ScoreOTCurrent + 30;
        }
        else if (snitchCatchT2OT.state == NSOnState) {
            t2ScoreOTCurrent = t2ScoreOTCurrent + 30;
        }
    }
    else if ([gameState isEqual:@"sdTime"]) {
        if (snitchCatchT1SD.state == NSOnState) {
            t1ScoreSDCurrent = t1ScoreSDCurrent + 30;
        }
        else if (snitchCatchT2SD.state == NSOnState) {
            t2ScoreSDCurrent = t2ScoreSDCurrent + 30;
        }
    }
    [self scoreFieldsUpdate];
    [self updateWindowScore];
}

-(void)scoreFieldsUpdate {
    if ([gameState  isEqual: @"regTime"]) {
        [t1Score setIntegerValue:t1ScoreCurrent];
        [t2Score setIntegerValue:t2ScoreCurrent];
    }
    else if ([gameState  isEqual: @"oTime"]) {
        [t1OTScore setIntegerValue:t1ScoreOTCurrent];
        [t2OTScore setIntegerValue:t2ScoreOTCurrent];
    }
    else if ([gameState isEqual: @"sdTime"]) {
        [t1SDScore setIntegerValue:t1ScoreSDCurrent];
        [t2SDScore setIntegerValue:t2ScoreSDCurrent];
    }
}

/* -(void)updateTimeKeeper:(NSTimer *)theTimer {
    currentTime ++;
    hours = currentTime / 3600;
    minutes = (currentTime % 3600) / 60;
    seconds = (currentTime %3600) % 60;
    playClock.stringValue = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

-(void)timeKeeper {
    currentTime = hours = minutes = seconds = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimeKeeper:) userInfo:nil repeats:YES];
} */

- (IBAction)buttonStateManager:(id)sender {
    if(startGame.state == NSOnState) {
        [self onStartPressed];
        startGame.state = NSOffState;
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
    }
    else if (startGameOT.state == NSOnState) {
        [self onStartGameOTPressed];
        startGameOT.state = NSOffState;
    }
    else if(stopPlayOT.state == NSOnState) {
        [self onStopPlayOTPressed];
        stopPlayOT.state = NSOffState;
    }
    else if (endGameOT.state == NSOnState) {
        [self onEndGameOTPressed];
        endGameOT.state = NSOffState;
    }
    else if (startGameSD.state == NSOnState) {
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
}

- (void)otDisabled {
    [startGameOT setEnabled:NO];
    [stopPlayOT setEnabled:NO];
    [endGameOT setEnabled:NO];
    [addGoalT1OT setEnabled:NO];
    [addGoalT2OT setEnabled:NO];
    [remGoalT1OT setEnabled:NO];
    [remGoalT2OT setEnabled:NO];
}

- (void)sdDisabled {
    [startGameSD setEnabled:NO];
    [stopPlaySD setEnabled:NO];
    [endGameSD setEnabled:NO];
    [addGoalT1SD setEnabled:NO];
    [addGoalT2SD setEnabled:NO];
    [remGoalT1SD setEnabled:NO];
    [remGoalT2SD setEnabled:NO];
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
    if (snitchPitchTrue) {
        [snitchPitch setEnabled:NO];
    }
    else {
        [snitchPitch setEnabled:YES];
    }
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
    NSString *teamAWindow = teamOne.stringValue;
    NSString *teamBWindow = teamTwo.stringValue;
    NSMutableString *windowString = [NSMutableString stringWithFormat:@"Snitchkeeper - %@", teamAWindow];
    if (((snitchCatchT1.state == NSOnState && ([gameState isEqual:@"regTime"])) || ((snitchCatchT1OT.state == NSOnState && ([gameState isEqual:@"oTime"])) || (snitchCatchT1SD.state == NSOnState && ([gameState isEqual:@"sdTime"]))))) {
        [windowString appendFormat:@" (*%@",scoreWindowA];
    }
    else {
    [windowString appendFormat:@" (%@",scoreWindowA];
    }
    [windowString appendFormat:@") %@", teamBWindow];
    if (((snitchCatchT1.state == NSOnState && ([gameState isEqual:@"regTime"])) || ((snitchCatchT1OT.state == NSOnState && ([gameState isEqual:@"oTime"])) || (snitchCatchT1SD.state == NSOnState && ([gameState isEqual:@"sdTime"]))))) {
    [windowString appendFormat:@" (*%@", scoreWindowb];
    }
    else {
        [windowString appendFormat:@" (%@", scoreWindowb];
    }
    [windowString appendString:@") "];
    
    snitchKeeper.title = windowString;
}

@end