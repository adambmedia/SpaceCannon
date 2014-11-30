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
#import "PluckyInstrument.h"
#import "LaserInstrument.h"
#import "ZwoopInstrument.h"
#import "SirenInstrument.h"
#import "SpaceVerb.h"

@implementation Conductor
{
    SoftBoingInstrument *softBoingInstrument;
    CrunchInstrument *crunchInstrument;
    PluckyInstrument *pluckyInstrument;
    LaserInstrument *laserInstrument;
    ZwoopInstrument *zwoopInstrument;
    SirenInstrument *sirenInstrument;
    SpaceVerb *spaceVerb;
    
    CGSize playFieldSize;
}

- (instancetype)initWithPlayfieldSize:(CGSize)size
{
    self = [super init];
    if (self) {
        playFieldSize = size;
        
        softBoingInstrument = [[SoftBoingInstrument alloc] init];
        [AKOrchestra addInstrument:softBoingInstrument];
        
        crunchInstrument = [[CrunchInstrument alloc] init];
        [AKOrchestra addInstrument:crunchInstrument];
        
        pluckyInstrument = [[PluckyInstrument alloc] init];
        [AKOrchestra addInstrument:pluckyInstrument];
        
        laserInstrument = [[LaserInstrument alloc] init];
        [AKOrchestra addInstrument:laserInstrument];
        
        zwoopInstrument = [[ZwoopInstrument alloc] init];
        [AKOrchestra addInstrument:zwoopInstrument];
        
        sirenInstrument = [[SirenInstrument alloc]init];
        [AKOrchestra addInstrument:sirenInstrument];
        
        
        
        spaceVerb = [[SpaceVerb alloc] initWithSoftBoing:softBoingInstrument.auxilliaryOutput
                                                  crunch:crunchInstrument.auxilliaryOutput
                                                   pluck:pluckyInstrument.auxilliaryOutput
                                                   laser:laserInstrument.auxilliaryOutput
                                                   zwoop:zwoopInstrument.auxilliaryOutput
                                                   siren:sirenInstrument.auxilliaryOutput];
        [AKOrchestra addInstrument:spaceVerb];
        
        [AKOrchestra start];
        [spaceVerb play];
    }
    
    return self;
}

- (void)resetAll
{
    [sirenInstrument stop];
}

// -----------------------------------------------------------------------------
#  pragma mark - Halo Lifespan Events
// -----------------------------------------------------------------------------

- (void)haloHitEdgeAtPosition:(CGPoint)position
{
    float pan = 0.0;
    if (position.x > playFieldSize.width/2.0) pan = 1.0;
    
    float frequency = 1200 - position.y;
    
    Pluck  *newPluck = [[Pluck alloc] initWithFrequency:frequency
                                                    pan:pan];
    [pluckyInstrument playNote:newPluck];
}

- (void)haloHitBallAtPosition:(CGPoint)position
{
    float pan = position.x/playFieldSize.width;
    float y = position.y / playFieldSize.height;
    
    [crunchInstrument playForDuration:1.4];
    Crunch *crunch = [[Crunch alloc] initWithIntensity:53
                                               damping:0.43+0.2*y
                                                   pan:pan];
    [[crunch intensity] randomize];
    [crunchInstrument playNote:crunch];
}

- (void)haloHitShieldAtPosition:(CGPoint)position {
    [self haloHitBallAtPosition:position];
}

- (void)haloHitLifeBar
{
    Crunch *deepCrunch = [[Crunch alloc] initAsDeepCrunch];
    deepCrunch.duration.value = 2.0;
    [crunchInstrument playNote:deepCrunch];
}

// -----------------------------------------------------------------------------
#  pragma mark - Shield Power Up Events
// -----------------------------------------------------------------------------

- (void)spawnedShieldPowerUpAtPosition:(CGPoint)position {
    [sirenInstrument playForDuration:4.0];
}

- (void)updateShieldPowerUpPosition:(CGPoint)position
{
    float pan = position.x/playFieldSize.width;
    sirenInstrument.pan.value = pan;
}

- (void)replacedShieldAtPosition:(CGPoint)position {
    [sirenInstrument stop];
    float pan = position.x/playFieldSize.width;
    Zwoop *zwoop = [[Zwoop alloc] initWithPan:pan];
    [zwoopInstrument playNote:zwoop];
}


// -----------------------------------------------------------------------------
#  pragma mark - Player Events
// -----------------------------------------------------------------------------

- (void)playerShotBallWithRotationVector:(CGVector)rotationVector remaningAmmo:(int)remainingAmmo
{
    LaserNote *laser = [[LaserNote alloc] initWithSpeed:1.0 + (8.0 / (remainingAmmo+1)) pan:(1.0+rotationVector.dx)/2.0];
    [laserInstrument playNote:laser];
}

- (void)attemptedShotWithoutAmmo {
    LaserNote *laser = [[LaserNote alloc] initWithSpeed:10.0 pan:0.5];
    [laserInstrument playNote:laser];
}

- (void)ballBouncedAtPosition:(CGPoint)position
{
    float pan = position.x/playFieldSize.width;
    SoftBoing *note = [[SoftBoing alloc] initWithPan:pan];
    [softBoingInstrument playNote:note];
}

- (void)multiplierModeStartedWithPointValue:(int)points {
    float feedbackLevel = 0.8 + points*0.075;
    spaceVerb.feedbackLevel.value = feedbackLevel;
}

- (void)multiplierModeEnded {
    spaceVerb.feedbackLevel.value = 0.8;
}



@end
