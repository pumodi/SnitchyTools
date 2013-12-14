//
//  Snitchkeeper.h
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Snitchkeeper : NSObject <NSApplicationDelegate> {
    IBOutlet NSWindow *snitchKeeper;
    IBOutlet NSButton *addGoalT1;
    IBOutlet NSButton *addGoalT1OT;
    IBOutlet NSButton *addGoalT1SD;
    IBOutlet NSButton *addGoalT2;
    IBOutlet NSButton *addGoalT2OT;
    IBOutlet NSButton *addGoalT2SD;
    IBOutlet NSButton *remGoalT1;
    IBOutlet NSButton *remGoalT1OT;
    IBOutlet NSButton *remGoalT1SD;
    IBOutlet NSButton *remGoalT2;
    IBOutlet NSButton *remGoalT2OT;
    IBOutlet NSButton *remGoalT2SD;
    IBOutlet NSButton *snitchCatchT1;
    IBOutlet NSButton *snitchCatchT1OT;
    IBOutlet NSButton *snitchCatchT1SD;
    IBOutlet NSButton *snitchCatchT2;
    IBOutlet NSButton *snitchCatchT2OT;
    IBOutlet NSButton *snitchCatchT2SD;
    IBOutlet NSButton *startGame;
    IBOutlet NSButton *stopPlay;
    IBOutlet NSButton *stopPlaySeekerContinue;
    IBOutlet NSButton *endGame;
    IBOutlet NSButton *snitchPitch;
    IBOutlet NSButton *startGameOT;
    IBOutlet NSButton *stopPlayOT;
    IBOutlet NSButton *endGameOT;
    IBOutlet NSButton *startGameSD;
    IBOutlet NSButton *stopPlaySD;
    IBOutlet NSButton *endGameSD;
    IBOutlet NSButton *penalty;
    IBOutlet NSButton *commitGame;
    IBOutlet NSPopUpButton *teamOne;
    IBOutlet NSPopUpButton *teamTwo;
    IBOutlet NSPopUpButton *snitch;
    IBOutlet NSButton *help;
    IBOutlet NSTextField *playClock;
    IBOutlet NSTextField *seekerFloor;
    IBOutlet NSTextField *otClock;
    IBOutlet NSTextField *sdClock;
    IBOutlet NSTextField *t1Score;
    IBOutlet NSTextField *t2Score;
    IBOutlet NSTextField *t1OTScore;
    IBOutlet NSTextField *t2OTScore;
    IBOutlet NSTextField *t1SDScore;
    IBOutlet NSTextField *t2SDScore;
    NSTimer *timer;
}

@property (nonatomic, retain) NSTextField *playClock;
-(void)updateTimeKeeper:(NSTimer *)theTimer;
-(void)timeKeeper;

@end
