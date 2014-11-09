//
//  Conductor.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/8/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "Conductor.h"

#import "AKFoundation.h"

// import any instruments here

@implementation Conductor
{
    //SeqInstrument *instrument;
    //AKSequence *sequence;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        AKOrchestra *orchestra = [[AKOrchestra alloc] init];
        //instrument = [[SeqInstrument alloc] init];
        //[orchestra addInstrument:instrument];
        [[AKManager sharedAKManager] runOrchestra:orchestra];
    }
    return self;
}


- (void)haloHitLeftEdgeAtPosition:(float)position {
    NSLog(@"Halo hit left edge at position %f", position);
}
- (void)haloHitRightEdgeAtPosition:(float)position {
    NSLog(@"Halo hit right edge at position %f", position);
}



@end
