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
//#import "DeepCrunchInstrument.h"
#import "BuzzInstrument.h"
#import "SpaceVerb.h"

@implementation Conductor
{
    SoftBoingInstrument *softBoingInstrument;
    CrunchInstrument *crunchInstrument;
//    DeepCrunchInstrument *deepCrunchInstrument;
    BuzzInstrument *buzzInstrument;
    SpaceVerb *spaceVerb;
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
//        deepCrunchInstrument = [[DeepCrunchInstrument alloc]init];
//        [orchestra addInstrument:deepCrunchInstrument];
        buzzInstrument = [[BuzzInstrument alloc] init];
        [orchestra addInstrument:buzzInstrument];
        spaceVerb = [[SpaceVerb alloc] initWithSoftBoing:softBoingInstrument.auxilliaryOutput
                                                  crunch:crunchInstrument.auxilliaryOutput
//                                              deepCrunch:deepCrunchInstrument.auxilliaryOutput
                                                    buzz:buzzInstrument.auxilliaryOutput];
        [orchestra addInstrument:spaceVerb];
        [[AKManager sharedAKManager] runOrchestra:orchestra];
        
        [spaceVerb play];
    }
    
    return self;
}


- (void)haloHitEdgeAtHeight:(float)height onEdge:(NSString *)edge {
    float pan = 0.0;
    if ([edge isEqualToString:@"right"]) pan = 1.0;

    float amplitude = 1.2-(height/640.0)*0.9;
    float frequency = 1200 - height;
    Buzz  *newBuzz = [[Buzz alloc] initWithFrequency:frequency amplitude:amplitude pan:0];
    [buzzInstrument playNote:newBuzz];
}

- (void)playerShotBallWithRotationVector:(CGVector)rotationVector remaningAmmo:(int)remainingAmmo {
    //    NSLog(@"Player shot at X %f Y% and has %d ammo left" , rotationVector.dx, rotationVector.dy, remainingAmmo);
}

- (void)haloHitBallAtPosition:(CGPoint)position withinRectangleOfSize:(CGSize)size {
    //    NSLog(@"Halo hit ball at %f", position);
    float yDistance = position.y / size.height;
    float xDistance = (2.0*position.x / size.width) - 1.0;
    [crunchInstrument playForDuration:1.4];
    Crunch *crunch = [[Crunch alloc] initWithCount:53
                                           damping:0.43+0.2*yDistance
                                               pan:xDistance];
    [crunchInstrument playNote:crunch];
}

- (void)haloHitLifeBar:(float)position;{
    //    NSLog(@"Halo hit life bar at %f", position);
    Crunch *deepCrunch = [[Crunch alloc] initAsDeepCrunch];
    deepCrunch.duration.value = 2.0;
    [crunchInstrument playNote:deepCrunch];
}

- (void)bounceOccuredOnEdge:(NSString *)edge {
    float pan = 0.0;
    if ([edge isEqualToString:@"right"]) pan = 1.0;
    
    SoftBoing *note = [[SoftBoing alloc] initWithPan:pan];
    [softBoingInstrument playNote:note];
}

- (void)shieldUp{
    //    NSLog(@"Shield's up!");
}

@end
