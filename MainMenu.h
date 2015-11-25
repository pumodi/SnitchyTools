//
//  MainMenu.h
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainMenu : NSObject <NSApplicationDelegate> {
    IBOutlet NSButton *buttonSnitchkeeper;
    IBOutlet NSWindow *snitchKeeper;
    IBOutlet NSWindow *mainMenu;
    IBOutlet NSWindow *gameOutputWindow;
}

@property (assign) IBOutlet NSWindow *window;
- (IBAction)openWindow:(id)sender;


@end