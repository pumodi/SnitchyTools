//
//  SnitchyTools.m
//  Snitchy Tools
//
//  Created by Jeffrey Brice on 12/14/13.
//  Copyright (c) 2013 Spacebooke Games. All rights reserved.
//

#import "SnitchyTools.h"
#import "Snitchkeeper.h"

@implementation SnitchyTools

NSArray *firstArray, *secondArray, *thirdArray;

-(IBAction)exportToCSV:(id)sender {
    NSMutableString *csv = [NSMutableString stringWithString:@"Name,Date,Miles"];
    
    NSUInteger count = [firstArray count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count; i++ ) {
        [csv appendFormat:@"\n\"%@\",%@,\"%ld\"",
         [firstArray objectAtIndex:i],
         [secondArray objectAtIndex:i],
         (long)[[thirdArray objectAtIndex:i] integerValue]
         ];
        // instead of integerValue may be used intValue or other, it depends how array was created
    }
    
    NSString *yourFileName = @"your filename";
    NSError *error;
    BOOL res = [csv writeToFile:yourFileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!res) {
        NSLog(@"Error %@ while writing to file %@", [error localizedDescription], yourFileName );
    }
}

@end
