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

BOOL started = TRUE;
BOOL stopped = FALSE;
BOOL snitchPitchTrue = FALSE;

-(void)scoreManager:(id)sender {
    int t1ScoreCurrent = 0;
    int t2ScoreCurrent = 0;
    int t1ScoreOTCurrent = 0;
    int t2ScoreOTCurrent = 0;
    int t1ScoreSDCurrent = 0;
    int t2ScoreSDCurrent = 0;
    
    if (addGoalT1) {
        t1ScoreCurrent = t1ScoreCurrent + 10;
        [t1Score insertText:[NSString stringWithFormat:@"%d", t1ScoreCurrent]];
    }
    if (addGoalT1OT) {
        t1ScoreOTCurrent = t1ScoreOTCurrent + 10;
        [t1OTScore insertText:[NSString stringWithFormat:@"%d", t1ScoreOTCurrent]];
    }
    if (addGoalT1SD) {
        t1ScoreSDCurrent = t1ScoreSDCurrent + 10;
        [t1SDScore insertText:[NSString stringWithFormat:@"%d", t1ScoreSDCurrent]];
    }
    if (addGoalT2) {
        t2ScoreCurrent = t2ScoreCurrent + 10;
        [t2Score insertText:[NSString stringWithFormat:@"%d", t2ScoreCurrent]];
    }
    if (addGoalT2OT) {
        t2ScoreOTCurrent = t2ScoreOTCurrent + 10;
        [t2OTScore insertText:[NSString stringWithFormat:@"%d", t2ScoreOTCurrent]];
    }
    if (addGoalT2SD) {
        t2ScoreSDCurrent = t2ScoreSDCurrent + 10;
        [t2SDScore insertText:[NSString stringWithFormat:@"%d", t2ScoreSDCurrent]];
    }
}

- (IBAction)onStartPressed:(id)sender {
    if(started) {
        [startGame setEnabled:NO];
        [stopPlay setEnabled:YES];
        [stopPlayInjury setEnabled:YES];
        [stopPlaySeekerContinue setEnabled:YES];
        [endGame setEnabled:YES];
        if (snitchPitchTrue) {
            [snitchPitch setEnabled:NO];
        }
        else {
            [snitchPitch setEnabled:YES];
        }
    }
    else {
        started = TRUE;
    }
}

- (IBAction)onStopPressed:(id)sender {
    if(stopped) {
        [startGame setEnabled:YES];
        [stopPlay setEnabled:NO];
        [stopPlayInjury setEnabled:NO];
        [stopPlaySeekerContinue setEnabled:NO];
        [snitchPitch setEnabled:NO];
        [endGame setEnabled:YES];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onStopInjuryPressed:(id)sender {
    if(stopped) {
        // Game has stopped due to an injury
        [startGame setEnabled:YES];
        [stopPlay setEnabled:NO];
        [stopPlayInjury setEnabled:NO];
        [stopPlaySeekerContinue setEnabled:NO];
        [snitchPitch setEnabled:NO];
        [endGame setEnabled:NO];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onStopContinueSeekerFloorPressed:(id)sender {
    if(stopped) {
        // Gameplay clock stops, seeker floor clock continues to count down
        [startGame setEnabled:YES];
        [stopPlay setEnabled:NO];
        [stopPlayInjury setEnabled:NO];
        [stopPlaySeekerContinue setEnabled:NO];
        [snitchPitch setEnabled:NO];
        [endGame setEnabled:NO];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onEndGamePressed:(id)sender {
    if(stopped) {
        // Stops clock, enables OT buttons
        [startGame setEnabled:YES];
        [stopPlay setEnabled:NO];
        [stopPlayInjury setEnabled:NO];
        [stopPlaySeekerContinue setEnabled:NO];
        [snitchPitch setEnabled:NO];
        [endGame setEnabled:NO];
        [startGameOT setEnabled:YES];
    }
    else {
        stopped = TRUE;
    }
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


- (IBAction)onStartGameOTPressed:(id)sender {
    if(started) {
        // Stops clock, enables SD buttons
        [startGameOT setEnabled:NO];
        [startGame setEnabled:NO];
        [stopPlayOT setEnabled:YES];
        [stopPlayInjuryOT setEnabled:YES];
        [endGameOT setEnabled:YES];
    }
    else {
        started = TRUE;
    }
}

- (IBAction)onStopPlayInjuryOTPressed:(id)sender {
    if(stopped) {
        // Stops clock, enables SD buttons
        [startGameOT setEnabled:YES];
        [stopPlayOT setEnabled:NO];
        [stopPlayInjuryOT setEnabled:NO];
        [endGameOT setEnabled:NO];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onStopPlayOTPressed:(id)sender {
    if(stopped) {
        // Stops clock, enables SD buttons
        [startGameOT setEnabled:YES];
        [stopPlayOT setEnabled:NO];
        [stopPlayInjuryOT setEnabled:NO];
        [endGameOT setEnabled:YES];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onEndGameOTPressed:(id)sender {
    if(stopped) {
        // Stops clock, enables SD buttons
        [startGameOT setEnabled:YES];
        [stopPlayOT setEnabled:NO];
        [stopPlayInjuryOT setEnabled:NO];
        [endGameOT setEnabled:NO];
        [startGameSD setEnabled:YES];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onStartGameSDPressed:(id)sender {
    if(started) {
        [startGameSD setEnabled:NO];
        [startGameOT setEnabled:NO];
        [stopPlaySD setEnabled:YES];
        [stopPlayInjurySD setEnabled:YES];
        [endGameSD setEnabled:YES];
    }
    else {
        started = TRUE;
    }
}

- (IBAction)onStopPlayInjurySDPressed:(id)sender {
    if(stopped) {
        [startGameSD setEnabled:YES];
        [stopPlaySD setEnabled:NO];
        [stopPlayInjurySD setEnabled:NO];
        [endGameSD setEnabled:NO];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onStopPlaySDPressed:(id)sender {
    if(stopped) {
        [startGameSD setEnabled:YES];
        [stopPlaySD setEnabled:NO];
        [stopPlayInjurySD setEnabled:NO];
        [endGameSD setEnabled:YES];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onEndGameSDPressed:(id)sender {
    if(stopped) {
        [startGameSD setEnabled:YES];
        [stopPlaySD setEnabled:NO];
        [stopPlayInjurySD setEnabled:NO];
        [endGameSD setEnabled:NO];
    }
    else {
        stopped = TRUE;
    }
}

- (IBAction)onCommitGamePressed:(id)sender {
    [startGameSD setEnabled:NO];
    [startGameOT setEnabled:NO];
    [startGame setEnabled:NO];
}

@end