//
//  MainMenu.m
//  Snitchy Tools
//
//  Created by Jeff "ServerGuy" Brice on 11/27/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)openWindow:(id)sender {
    if (buttonSnitchkeeper) {
        
        [snitchKeeper makeKeyAndOrderFront:(self)];
        [mainMenu close];
    }
}

- (IBAction)newTournament:(id)sender {

}



@end