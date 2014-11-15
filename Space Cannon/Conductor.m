//
//  Conductor.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/8/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "Conductor.h"

#import "AKFoundation.h"

#import "SoftBoingInstrument.h"
#import "CrunchInstrument.h"

@implementation Conductor
{
    SoftBoingInstrument *softBoingInstrument;
    CrunchInstrument *crunchInstrument;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        AKOrchestra *orchestra = [[AKOrchestra alloc] init];
        softBoingInstrument = [[SoftBoingInstrument alloc] init];
        [orchestra addInstrument:softBoingInstrument];
        crunchInstrument = [[CrunchInstrument alloc] init];
        [orchestra addInstrument:crunchInstrument];
        [[AKManager sharedAKManager] runOrchestra:orchestra];
    }
    return self;
}


- (void)haloHitLeftEdgeAtPosition:(float)position {
//    NSLog(@"Halo hit left edge at position %f", position);
}
- (void)haloHitRightEdgeAtPosition:(float)position {
//    NSLog(@"Halo hit right edge at position %f", position);
}

- (void)playerShotBallWithRotationVector:(CGVector)rotationVector remaningAmmo:(int)remainingAmmo {
//    NSLog(@"Player shot at X %f Y% and has %d ammo left" , rotationVector.dx, rotationVector.dy, remainingAmmo);
}

- (void)haloHitBall:(float)position {
//    NSLog(@"Halo hit ball at %f", position);
    [crunchInstrument play];
}

- (void)haloHitLifeBar:(float)position;{
//    NSLog(@"Halo hit life bar at %f", position);
    [crunchInstrument play];
}

- (void)bounceOccured{
    [softBoingInstrument playNote:[[SoftBoing alloc] init]];
}

- (void)shieldUp{
//    NSLog(@"Shield's up!");
}

@end
