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
    IBOutlet NSWindow *spectator;
    IBOutlet NSPanel *penaltyWindow;
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
    IBOutlet NSTextField *otSeekerFloor;
    IBOutlet NSTextField *otClock;
    IBOutlet NSTextField *sdClock;
    IBOutlet NSTextField *t1Score;
    IBOutlet NSTextField *t2Score;
    IBOutlet NSTextField *t1OTScore;
    IBOutlet NSTextField *t2OTScore;
    IBOutlet NSTextField *t1SDScore;
    IBOutlet NSTextField *t2SDScore;
    IBOutlet NSTextField *clockWinT1Score;
    IBOutlet NSTextField *clockWinT2Score;
    IBOutlet NSTextField *clockWinT1;
    IBOutlet NSTextField *clockWinT2;
    IBOutlet NSTextField *clockWinRegTimeIndic;
    IBOutlet NSTextField *clockWinOverTimeIndic;
    IBOutlet NSTextField *clockWinSDTimeIndic;
    IBOutlet NSTextField *t1Name;
    IBOutlet NSTextField *t2Name;
    IBOutlet NSTextField *clockWinPlayClock;
    IBOutlet NSTextField *clockWinSeekerFloor;
    IBOutlet NSTextField *teamOneTextField;
    IBOutlet NSTextField *teamTwoTextField;
    IBOutlet NSTextField *clockWinSeekerFloorTitle;
    NSTimer *playClockTimer;
    NSTimer *seekerFloorTimer;
    NSTimer *otClockTimer;
    NSTimer *sdClockTimer;
    NSTimer *otSeekerFloorTimer;
    NSDate *startDate;
    NSDate *seekerDate;
    NSDate *otDate;
    NSDate *sdDate;
    NSDate *otSeekerDate;
    NSPopUpButton *_ipSelector;
    NSTextField *_ipPlayerName;
    NSTextField *_ipPlayerNumber;
    NSSegmentedControl *_ipTeamSelector;
    NSTextField *_ipEventDescription;
    NSTextField *_ipPenaltyLength;
    NSSegmentedControl *_ipCardValue;
    NSButton *_ipSubmitAtTime;
    NSTextField *_ipClockTime;
    
}

@property (nonatomic, retain) NSTextField *playClock;
@property (strong) IBOutlet NSPopUpButton *ipSelector;
@property (strong) IBOutlet NSTextField *ipPlayerName;
@property (strong) IBOutlet NSTextField *ipPlayerNumber;
@property (strong) IBOutlet NSSegmentedControl *ipTeamSelector;
@property (strong) IBOutlet NSTextField *ipEventDescription;
@property (strong) IBOutlet NSTextField *ipPenaltyLength;
@property (strong) IBOutlet NSSegmentedControl *ipCardValue;
@property (strong) IBOutlet NSButton *ipSubmitAtTime;
@property (strong) IBOutlet NSTextField *ipClockTime;
@end
