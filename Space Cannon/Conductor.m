//
//  Conductor.m
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/8/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "Conductor.h"

#import "AKFoundation.h"
#import "AKTools.h"

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

- (CGPoint)scaledPosition:(CGPoint)position
{
    float scaledX  = position.x / playFieldSize.width;
    float scaledY = (playFieldSize.height - position.y) / playFieldSize.height;
    return CGPointMake(scaledX, scaledY);
}


- (void)haloHitEdgeAtPosition:(CGPoint)position
{
    CGPoint scaled = [self scaledPosition:position];
    
    Pluck  *pluck = [[Pluck alloc] init];
    [AKTools scaleProperty:pluck.pan withScalingFactor:scaled.x];
    [AKTools scaleProperty:pluck.frequency withScalingFactor:scaled.y];
    [pluckyInstrument playNote:pluck];
}

- (void)haloHitBallAtPosition:(CGPoint)position
{
    CGPoint scaled = [self scaledPosition:position];
    
    Crunch *crunch = [[Crunch alloc] init];
    [AKTools scaleProperty:crunch.pan withScalingFactor:scaled.x];
    [AKTools scaleProperty:crunch.damping withInverseScalingFactor:scaled.y];
    [crunchInstrument playNote:crunch];
}

- (void)haloHitShieldAtPosition:(CGPoint)position
{
    [self haloHitBallAtPosition:position];
}

- (void)haloHitLifeBar
{
    Crunch *deepCrunch = [[Crunch alloc] initAsDeepCrunch];
    [crunchInstrument playNote:deepCrunch];
}

// -----------------------------------------------------------------------------
#  pragma mark - Shield Power Up Events
// -----------------------------------------------------------------------------

- (void)spawnedShieldPowerUpAtPosition:(CGPoint)position
{
    [sirenInstrument playForDuration:5.0];
}

- (void)updateShieldPowerUpPosition:(CGPoint)position
{
    CGPoint scaled = [self scaledPosition:position];
    [AKTools scaleProperty:sirenInstrument.pan withScalingFactor:scaled.x];
}

- (void)replacedShieldAtPosition:(CGPoint)position
{
    [sirenInstrument stop];
    
    CGPoint scaled = [self scaledPosition:position];
    Zwoop *zwoop = [[Zwoop alloc] init];
    [AKTools scaleProperty:zwoop.pan withScalingFactor:scaled.x];
    [zwoopInstrument playNote:zwoop];
}


// -----------------------------------------------------------------------------
#  pragma mark - Player Events
// -----------------------------------------------------------------------------

- (void)playerShotBallWithRotationVector:(CGVector)rotationVector
                            remaningAmmo:(int)remainingAmmo
{
    LaserNote *laser = [[LaserNote alloc] init];
    float scaledSpeed = (remainingAmmo+1)/laser.speed.maximum;
    [AKTools scaleProperty:laser.speed withInverseScalingFactor:scaledSpeed];
    laser.pan.value = rotationVector.dx;
    [laserInstrument playNote:laser];
}

- (void)attemptedShotWithoutAmmo
{
    LaserNote *laser = [[LaserNote alloc] init];
    laser.speed.value = 10;
    [laserInstrument playNote:laser];
}

- (void)ballBouncedAtPosition:(CGPoint)position
{
    CGPoint scaled = [self scaledPosition:position];

    SoftBoing *softBoing = [[SoftBoing alloc] init];
    [AKTools scaleProperty:softBoing.pan withScalingFactor:scaled.x];
    [AKTools scaleProperty:softBoing.amplitude withScalingFactor:scaled.y];
    [softBoingInstrument playNote:softBoing];
}

- (void)multiplierModeStartedWithPointValue:(int)points {
    float scaledPoints = (points - 1) / (float)points;
    [AKTools scaleProperty:spaceVerb.feedbackLevel withScalingFactor:scaledPoints];
}

- (void)multiplierModeEnded {
    spaceVerb.feedbackLevel.value = spaceVerb.feedbackLevel.minimum;
}

@end
